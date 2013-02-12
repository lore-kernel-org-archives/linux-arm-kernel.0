From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Feb 2013 14:11:47 +0100
Subject: ARM/Kernel: Problems with multiple VIC registration
In-Reply-To: <511A37CC.8030600@st.com>
References: <5110D55F.9040509@st.com>
 <CACRpkdZX4OyfYbcc2-sdf5LLJmBrGTa27_8swvcZ-rBP6-+1CQ@mail.gmail.com>
 <5111D387.9040803@st.com>
 <CACRpkdYMwijN_eE11wH-PxVazutfszBFni31_UX3PaFDcSeoUQ@mail.gmail.com>
 <511A37CC.8030600@st.com>
Message-ID: <CACRpkdZ4y8o6q1djRpg_VAxn-YY1AHG2BKR1aoAOfo0Ru2Vkwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 12, 2013 at 1:38 PM, Amit Virdi <amit.virdi@st.com> wrote:
> On 2/6/2013 2:45 PM, Linus Walleij wrote:

>> There are several things you can do wrong. For example a common mistake
>> is to offset the IRQs on a new platform from zero. So that the first
>> parameter to vic_init() is zero. This is not legal because Linux IRQ 0
>> is NO_IRQ and shall not be used. If this is your problems, IRQs shall
>> offset from something like 64 so you can even use SPARSE_IRQ.
>
> Yes, I was using 0 as the first offset in IRQs and my IRQs were defined from
> 0 to n. I changed it to 1 to n+1 and I'm now not using 0. Every problem
> seems to have resolved now.

1 and n+1 is only going to work as long as you're defining
NR_IRQS in the platform or in the .nr_irqs member of
the MACHINE record.

If you use device tree or SPARSE_IRQ (which, by the way,
you should turn on right now) you will run into trouble.

Bump it to 64+n.

Else you will just have to fix all this when you get to
submitting board support upstream.

Yours,
Linus Walleij
