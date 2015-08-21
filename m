From: vichy.kuo@gmail.com (vichy)
Date: Fri, 21 Aug 2015 13:27:30 +0800
Subject: is it possible to liimit the softirq re entrance times
In-Reply-To: <20150820200534.GU7557@n2100.arm.linux.org.uk>
References: <CAOVJa8FfHWGVf=ccXFCyTUD5YHrMAAeQ9Tkg1ipHA=J_CyVAHQ@mail.gmail.com>
 <20150820200534.GU7557@n2100.arm.linux.org.uk>
Message-ID: <CAOVJa8EPpncsR1ThfTKsczsc33QXqAxKtGVAfg-PD++6vwxsvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Russel:

2015-08-21 4:05 GMT+08:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Aug 21, 2015 at 01:09:23AM +0800, vichy wrote:
>> My question are:
>> 1. in __do_sofiq, there is a jiffies setting to make sure the whole
>> softirq will not took to long.
>> But in my case is there any many hard irq happen like below
>>
>>                         trace_softirq_entry(vec_nr);    ------a
>>                         h->action(h);
>>                         trace_softirq_exit(vec_nr);      ---------b
>>
>> from lttng, I see there 100 interrupt happen from entry to exit.
>
> Firstly, I don't trust the trace infrastructure all that much for
> performance measurements: it has a non-zero overhead (especially if
> you turn on stack tracing), and if you want to do these kinds of
> measurements, you first need to ascertain what that overhead is, so
> you can subtract the effect of having trace enabled from the
> observations.  It's quite possible that a number of those 100
> interrupts are happening in the trace code recording the softirq
> entry and exit events.
>
> Secondly, you seem to be saying that 100 interrupts happen in
> h->action().  You don't specify the frequency of those interrupts.
> You also don't mention (which is more important) how long h->action()
> takes to run.  You also don't say which softirq it is.
I pasted some part of trace I captured as below.

>
> From the sounds of it, whatever soft irq handler is running, it's the
> handler itself which is the cause of your problem, but not knowing any
> of the details in my second point above, it's impossible to tell.

I paste the log I got from trace
>You don't specify the frequency of those interrupts.
those are ramdomly happen because usb devices is receiving/sending data.
> You also don't mention (which is more important) how long h->action()
it is about 12.915016ms
> takes to run.  You also don't say which softirq it is.
the sofirq vec =1, from the kernel define, it should be TIMER_SOFTIRQ

Isn't there any upward bound for softirq interruptted by HW irq?

Sincerely appreciate your kind explaination,


enum
{
        HI_SOFTIRQ=0,
        TIMER_SOFTIRQ,
        NET_TX_SOFTIRQ,
        NET_RX_SOFTIRQ,
        BLOCK_SOFTIRQ,
        BLOCK_IOPOLL_SOFTIRQ,
        TASKLET_SOFTIRQ,
        SCHED_SOFTIRQ,
        HRTIMER_SOFTIRQ,
        RCU_SOFTIRQ,    /* Preferable RCU should always be the last softirq */

        NR_SOFTIRQS
};

43:08.755 688 556        bla_0        0        softirq_entry
vec=1        3        20
43:08.755 895 172        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.755 993 380        bla_0        0        mm_page_alloc
page=0xeb124c00, order=3, gfp_flags=16928, migratetype=0        3
  20
43:08.756 178 924        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.756 190 100        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.756 244 276        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.756 396 860        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.757 002 436        bla_0        0        irq_handler_entry
 irq=29, name=twd        3        20
43:08.757 040 244        bla_0        0        irq_handler_exit
irq=29, ret=1        3        20
43:08.757 046 268        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.757 785 772        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.757 800 220        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.758 586 644        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.758 598 196        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.759 040 900        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.759 113 724        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.759 480 276        bla_0        0        mm_page_alloc
page=0xeb11ff00, order=3, gfp_flags=16928, migratetype=0        3
  20
43:08.759 663 100        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.759 675 884        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.760 020 468        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.760 030 604        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.760 388 452        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.760 398 484        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.760 980 348        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.760 989 820        bla_0        0        irq_handler_entry
 irq=29, name=twd        3        20
43:08.761 029 324        bla_0        0        irq_handler_exit
irq=29, ret=1        3        20
43:08.761 035 908        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.761 753 780        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.761 767 956        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.762 125 924        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.762 135 964        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.762 190 300        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.762 276 580        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.762 733 724        bla_0        0        mm_page_alloc
page=0xeb12be00, order=3, gfp_flags=16928, migratetype=0        3
  20
43:08.762 943 404        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.762 963 852        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.763 678 020        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.763 689 796        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.764 390 884        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.764 402 372        bla_0        0        irq_handler_entry
 irq=29, name=twd        3        20
43:08.765 204 812        bla_0        0        irq_handler_exit
irq=29, ret=1        3        20
43:08.765 216 436        bla_0        0        irq_handler_entry
 irq=41, name=irq        3        20
43:08.765 242 924        bla_0        0        irq_handler_exit
irq=41, ret=1        3        20
43:08.765 264 092        bla_0        0        irq_handler_entry
 irq=53, name=irq        3        20
43:08.765 269 276        bla_0        0        irq_handler_exit
irq=53, ret=1        3        20
43:08.765 274 644        bla_0        0        irq_handler_entry
 irq=54, name=irq        3        20
43:08.765 290 572        bla_0        0        irq_handler_exit
irq=54, ret=1        3        20
43:08.765 298 316        bla_0        0        irq_handler_entry
 irq=55, name=irq        3        20
43:08.765 423 564        bla_0        0        irq_handler_exit
irq=55, ret=1        3        20
43:08.765 433 724        bla_0        0        irq_handler_entry
 irq=80, name=irq        3        20
43:08.765 450 188        bla_0        0        irq_handler_exit
irq=80, ret=1        3        20
43:08.765 456 628        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.765 711 252        bla_0        0        mm_page_alloc
page=0xeb123f40, order=1, gfp_flags=2118176, migratetype=0        3
    20
43:08.766 252 228        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.766 266 716        bla_0        0        irq_handler_entry
 irq=54, name=irq        3        20
43:08.766 282 220        bla_0        0        irq_handler_exit
irq=54, ret=1        3        20
43:08.766 288 460        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.766 550 108        bla_0        0        mm_page_alloc
page=0xeb12b600, order=3, gfp_flags=16928, migratetype=0        3
  20
43:08.767 185 100        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.767 203 156        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.767 949 260        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.767 960 020        bla_0        0        irq_handler_entry
 irq=87, name=ehci_hcd:usb3        3        20
43:08.768 395 340        bla_0        0        irq_handler_exit
irq=87, ret=1        3        20
43:08.768 496 332        bla_0        0        irq_handler_entry
 irq=29, name=twd        3        20
43:08.768 537 452        bla_0        0        irq_handler_exit
irq=29, ret=1        3        20
43:08.768 603 572        bla_0        0        softirq_exit
vec=1        3        20
