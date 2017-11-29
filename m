From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Nov 2017 21:17:44 +0100
Subject: kasan: false use-after-scope warnings with KCOV
In-Reply-To: <20171128152405.vkwxdbkbuokjt2hv@lakrids.cambridge.arm.com>
References: <20171128123555.mo4ikj2ru6mkibwo@lakrids.cambridge.arm.com>
 <CACT4Y+Z2VhaDiFdg3aoi5uEsX7M+5-XMGH4PApys=qXKSMVUFg@mail.gmail.com>
 <20171128141355.3pwgzfhji32lehf2@lakrids.cambridge.arm.com>
 <20171128152405.vkwxdbkbuokjt2hv@lakrids.cambridge.arm.com>
Message-ID: <CAK8P3a2HhfiYs1fhUGH4TSP+LFeaFJswOyQYN=joxc+HNBcDwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 4:24 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Nov 28, 2017 at 02:13:55PM +0000, Mark Rutland wrote:
>> On Tue, Nov 28, 2017 at 01:57:49PM +0100, Dmitry Vyukov wrote:
>> > On Tue, Nov 28, 2017 at 1:35 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > > As a heads-up, I'm seeing a number of what appear to be false-positive
>> > > use-after-scope warnings when I enable both KCOV and KASAN (inline or outline),
>> > > when using the Linaro 17.08 GCC7.1.1 for arm64. So far I haven't spotted these
>> > > without KCOV selected, and I'm only seeing these for sanitize-use-after-scope.
>> > >
>> > > The reports vary depending on configuration even with the same trigger. I'm not
>> > > sure if it's the reporting that's misleading, or whether the detection is going
>> > > wrong.
>
>> ... it looks suspiciously like something is setting up non-zero shadow
>> bytes, but not zeroing them upon return.
>
> It looks like this is the case.
>
> The hack below detects leftover poison on an exception return *before*
> the false-positive warning (example splat at the end of the email). With
> scripts/Makefile.kasan hacked to not pass
> -fsanitize-address-use-after-scope, I see no leftover poison.

That reminds me that we are still missing my patch to turn off
-fsanitize-address-use-after-scope by default and instead re-enable
CONFIG_FRAME_WARN when KASAN is turned on.

I spent about a year hunting down all the instances that produce more
than 2KB stack frames with KASAN (including asan-stack), they should
be disabled now, but we still have some seriously large stack frames with
 -fsanitize-address-use-after-scope.

Maybe it's better to just completely disable  -fsanitize-address-use-after-scope
when it has multiple independent problems.

        Arnd
