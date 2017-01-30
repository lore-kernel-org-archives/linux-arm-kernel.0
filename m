From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 30 Jan 2017 17:26:04 +0000
Subject: [RFC v2 10/10] KVM: arm/arm64: Emulate the EL1 phys timer
 register access
In-Reply-To: <CAHyh4xhgNYjpyaGz=UtFfC+smh6CVZgJ530WWmwwmpg=Bi799A@mail.gmail.com>
References: <1485479100-4966-1-git-send-email-jintack@cs.columbia.edu>
 <1485479100-4966-11-git-send-email-jintack@cs.columbia.edu>
 <86lgtt98gs.fsf@arm.com>
 <CAHyh4xhgNYjpyaGz=UtFfC+smh6CVZgJ530WWmwwmpg=Bi799A@mail.gmail.com>
Message-ID: <CAFEAcA8BfUQTrdpNtkkB2kh=dLyOCjuBv2vVWZML8px8D0JJ9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 January 2017 at 17:08, Jintack Lim <jintack@cs.columbia.edu> wrote:
> On Sun, Jan 29, 2017 at 10:44 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> Shouldn't we take the ENABLE bit into account? The ARMv8 ARM version I
>> have at hand (version h) seems to indicate that we should, but we should
>> check with the latest and greatest...
>
> Thanks! I was not clear about this. I have ARM ARM version k, and it
> says that 'When the value of the ENABLE bit is 0, the ISTATUS field is
> UNKNOWN.' So I thought the istatus value doesn't matter if ENABLE is
> 0, and just set istatus bit regardless of ENABLE bit. If this is not
> what the manual meant, then I'm happy to fix this.

It looks like the spec has been relaxed between the doc version
that Marc was looking at and the current one. So it's OK for
an implementation to either (a) set ISTATUS to 0 if ENABLE
is 0, or (b) do what you've done and set ISTATUS according
to the timer comparison whether ENABLE is clear or not
(or even (c) set ISTATUS to a random value if ENABLE is clear,
and other less likely choices).
I think we should add a comment to note that it's architecturally
UNKNOWN and we've made a choice for our implementation convenience.

thanks
-- PMM
