From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Aug 2015 21:05:34 +0100
Subject: is it possible to liimit the softirq re entrance times
In-Reply-To: <CAOVJa8FfHWGVf=ccXFCyTUD5YHrMAAeQ9Tkg1ipHA=J_CyVAHQ@mail.gmail.com>
References: <CAOVJa8FfHWGVf=ccXFCyTUD5YHrMAAeQ9Tkg1ipHA=J_CyVAHQ@mail.gmail.com>
Message-ID: <20150820200534.GU7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 01:09:23AM +0800, vichy wrote:
> My question are:
> 1. in __do_sofiq, there is a jiffies setting to make sure the whole
> softirq will not took to long.
> But in my case is there any many hard irq happen like below
> 
>                         trace_softirq_entry(vec_nr);    ------a
>                         h->action(h);
>                         trace_softirq_exit(vec_nr);      ---------b
> 
> from lttng, I see there 100 interrupt happen from entry to exit.

Firstly, I don't trust the trace infrastructure all that much for
performance measurements: it has a non-zero overhead (especially if
you turn on stack tracing), and if you want to do these kinds of
measurements, you first need to ascertain what that overhead is, so
you can subtract the effect of having trace enabled from the
observations.  It's quite possible that a number of those 100
interrupts are happening in the trace code recording the softirq
entry and exit events.

Secondly, you seem to be saying that 100 interrupts happen in
h->action().  You don't specify the frequency of those interrupts.
You also don't mention (which is more important) how long h->action()
takes to run.  You also don't say which softirq it is.

>From the sounds of it, whatever soft irq handler is running, it's the
handler itself which is the cause of your problem, but not knowing any
of the details in my second point above, it's impossible to tell.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
