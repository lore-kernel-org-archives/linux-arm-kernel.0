From: keescook@chromium.org (Kees Cook)
Date: Tue, 4 Nov 2014 12:02:32 -0800
Subject: [RFC PATCH] make CONFIG_STRICT_DEVMEM a core non-debug feature
In-Reply-To: <20141104195914.GY22224@bivouac.eciton.net>
References: <1415121836-16241-1-git-send-email-leif.lindholm@linaro.org>
 <CAGXu5jL1BBAvoxVqFa1YHJSMCbGdLiPey-dyC15YKVPB2xGfig@mail.gmail.com>
 <20141104195914.GY22224@bivouac.eciton.net>
Message-ID: <CAGXu5jJnaAFMUBR50TgapRzRcvKS0j=XO7u9z6fdNouwMb=_sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 4, 2014 at 11:59 AM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Tue, Nov 04, 2014 at 10:43:00AM -0800, Kees Cook wrote:
>> > diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
>> > index efefd12..39f7817 100644
>> > --- a/drivers/char/Kconfig
>> > +++ b/drivers/char/Kconfig
>> > @@ -6,6 +6,22 @@ menu "Character devices"
>> >
>> >  source "drivers/tty/Kconfig"
>> >
>> > +config STRICT_DEVMEM
>> > +       bool "Reduced access to /dev/mem"
>> > +       depends on HAVE_ARCH_RESTRICTED_DEVMEM
>> > +       default y
>> > +       help
>> > +         If this option is disabled, you allow userspace (root) access to all
>> > +         of memory, including kernel and userspace memory. Accidental
>> > +         access to this is obviously disastrous, but specific access can
>> > +         be used by people debugging the kernel.
>> > +
>> > +         If this option is switched on, the /dev/mem file restricts userspace
>> > +         access to an architecture-specific subset of the physical address
>> > +         space.
>>
>> Great consolidation, thanks! I would probably expand this help text a
>> bit to include some of details mentioned in the x86 portion of the
>> option. For example:
>>
>>
>> If this option is switched on, the /dev/mem file restricts userspace
>> access to an architecture-specific subset of the physical address
>> space. For example on x86, PCI space and BIOS code and data
>> regions. This is sufficient for things like dosemu and non-KMS
>> Xorg and all common users of /dev/mem.
>
> I considered doing that, but didn't want to risk listing too many
> details of one architecture, and too few of others.

Well, the others only say "memory mapped peripherals", so that's what
I was suggesting adding the x86 language: it was the most detailed
about what that would really mean to the end-user.

> One alternative would be to add a devmem.txt somewhere in
> Documentation, listing the behaviours on different architectures (this
> would also be a good place to describe restrictions on types of
> mappings and suchlike). The help message could then contain a mention
> of that file. Would that work for you?

That's fine too, but feels like overkill to me. Just adding the x86
example to the common help text seemed like a reasonable consolidation
of the existing help texts. I just didn't want to lose detail when
dropping the x86 text.

> I really don't have a strong opinion however, and would be happy to go
> along with whatever the most people would like to see.

Either way, I'm all for the consolidation. :)

-Kees

-- 
Kees Cook
Chrome OS Security
