From: ryan@presslab.us (Ryan Press)
Date: Wed, 20 Mar 2013 09:44:42 -0700
Subject: [PATCH for 3.9-rc] arm: mvebu: Use local interrupt only for the
 timer 0
In-Reply-To: <1363792175-3136-1-git-send-email-gregory.clement@free-electrons.com>
References: <1363792175-3136-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CABx3TkU=y5_WTojbc9z17csaUh4PYxDUszdCdpWhmDM-JUEt5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 8:09 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> The commit 3a6f08a37 "arm: mvebu: Add support for local interrupt",
> managed the 28th first interrupts as local interrupt to match the
> hardware specification. Among these interrupts there are the Gigabits
> Ethernet ones used by the mvneta driver. Unfortunately the state of
> the percpu_irq API prevents the driver to use it.
>
> Indeed the interrupts have to be freed when the .stop() function is
> called. As the free_percpu_irq() function don't disable the interrupt
> line, we have to do it on each CPU before calling this. The function
> disable_percpu_irq() only disable the percpu on the current CPU and
> there is no function which allows to disable a percpu irq on a given
> CPU. Waiting for the extension of the percpu_irq API, this fix allows
> to use again the mvneta driver.

Thanks Gregory!

I can confirm this patch works for me as well.  I still have the
problem on my Globalscale Mirabox where only a forced 10Mb link works
on tx/rx.  With 100Mb only rx works, and 1Gb neither works.

Ryan
