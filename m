From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 23 Oct 2015 13:49:06 -0400
Subject: [PATCH] Revert "serial: amba-pl011: fix incorrect integer size in
 pl011_fifo_to_tty()"
In-Reply-To: <562A6296.3070600@codeaurora.org>
References: <1445594400-29095-1-git-send-email-shijie.huang@arm.com>
 <20151023103056.GI4801@e103592.cambridge.arm.com>
 <562A297A.9030204@codeaurora.org>
 <20151023133403.GI4796@e103592.cambridge.arm.com> <562A544D.7080506@tabi.org>
 <20151023160246.GM4796@e103592.cambridge.arm.com>
 <562A6296.3070600@codeaurora.org>
Message-ID: <562A7312.5030501@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2015 12:38 PM, Timur Tabi wrote:
> On 10/23/2015 11:02 AM, Dave P Martin wrote:
>> I'm pretty sure CREAD should default to enabled[1], and that usually
>> software won't modify it.
>>
>> Assuming that this is indeed the problem, it's possible that another bug
>> in the pl011 driver is wrongly clearing this flag.  Sadly I don't have
>> time to look at the code again just now ...:(
> 
> Perhaps, but !CREAD is definitely broken without this patch.  So if the driver really is clearing CREAD somewhere else, then that's where the real bug is.
> 
>>
>> Could be interesting to stick some BUG_ON(!CREAD) in the driver to
>> try and track down where that's coming from.
> 
> CREAD is disabled by default when opening the console.  You need to explicitly set it in the termios structure.

No; the initial termios structure for all serial core-based drivers has
CREAD set:

pl011_probe
   pl011_register_port
      uart_register_driver
         ...
         normal->init_termios.c_cflag = .... | CREAD | ....;

Regards,
Peter Hurley
