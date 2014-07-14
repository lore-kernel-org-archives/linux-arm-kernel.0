From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 14 Jul 2014 05:41:03 -0400 (EDT)
Subject: [PATCH v10 03/11] ARM: hisi: enable MCPM implementation
In-Reply-To: <CAD6h2NQzV_=y=OqmGonzZTspoZiV5oRg3c52cCO-F1rYJUzZRg@mail.gmail.com>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
 <1404957850-13340-4-git-send-email-haojian.zhuang@linaro.org>
 <alpine.DEB.2.10.1407101714400.2893@Yrabib>
 <CAD6h2NQzV_=y=OqmGonzZTspoZiV5oRg3c52cCO-F1rYJUzZRg@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1407140538030.3647@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Jul 2014, Haojian Zhuang wrote:

> On 13 July 2014 05:31, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Thu, 10 Jul 2014, Haojian Zhuang wrote:
> >
> >> +static void __naked hip04_mcpm_power_up_setup(unsigned int affinity_level)
> >> +{
> >> +     asm volatile ("                 \n"
> >> +     /* calculate fabric phys address */
> >> +"    adr     r2, 2f                  \n"
> >> +"    ldmia   r2, {r1, r3}            \n"
> >> +"    sub     r0, r2, r1              \n"
> >> +"    add     r2, r0, r3              \n"
> >> +"    ldr     r2, [r2]                \n"
> >
> > You may replace the above 2 instructions with "ldr r2, [r0, r3]".
> >
> OK.
> 
> >> +     /* get cluster id from MPIDR */
> >> +"    mrc     p15, 0, r0, c0, c0, 5   \n"
> >> +"    ubfx    r1, r0, #8, #8          \n"
> >> +"    and     r1, r1, #0xf            \n"
> >
> > You don't need the "and" here.  It is implicit in ubfx.
> >
> OK.
> 
> >> +     /* 1 << cluster id */
> >> +"    mov     r0, #1                  \n"
> >> +"    mov     r3, r0, lsl r1          \n"
> >> +"    ldr     r0, [r2, #"__stringify(FAB_SF_MODE)"]   \n"
> >> +"    tst     r0, r3                  \n"
> >> +"    bxne    lr                      \n"
> >
> > Instead of running all this code all the time, you could simply test r0
> > at the very beginning and if it is not equal to 1 then return
> > immediately. If it is 1 that means the CPU executing this code is the
> > first one to run in the cluster, in which case you also don't have to
> > test if the cluster snoop is already enabled here.
> >
> 
> Since I need to enable the cluster snoop for cluster 0. At this time,
> it's not enabled although core0 is running.

Yes, hence my next comment.

> >> +"    orr     r1, r0, r3              \n"
> >> +"    str     r1, [r2, #"__stringify(FAB_SF_MODE)"]   \n"
> >> +"1:  ldr     r0, [r2, #"__stringify(FAB_SF_MODE)"]   \n"
> >> +"    tst     r0, r3                  \n"
> >> +"    beq     1b                      \n"
> >> +"    bx      lr                      \n"
> >> +
> >> +"    .align  2                       \n"
> >> +"2:  .word   .                       \n"
> >> +"    .word   fabric_phys_addr        \n"
> >> +     );
> >> +}
> >
> > Of course you will also have to enable the snoops for the current
> > cluster in hip04_cpu_table_init() as well.
> 
> It means that I need to reserve the copy to enable the snoop in c code
> for cluster 0. Is it right?

Yes. And it can be __init just like hip04_cpu_table_init().


Nicolas
