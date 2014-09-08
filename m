From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 08 Sep 2014 19:43:44 +0400
Subject: [PATCHv2] rtc: pcf8563: fix uninitialized use warning
In-Reply-To: <2750370.rlMuFcoBUA@wuerfel>
References: <2750370.rlMuFcoBUA@wuerfel>
Message-ID: <540DCEB0.6030108@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/8/2014 7:26 PM, Arnd Bergmann wrote:

> gcc-4.9 found a potential condition under which the 'pending'
> variable may be used uninitialized:

> drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_irq':
> drivers/rtc/rtc-pcf8563.c:173:5: warning: 'pending' may be used uninitialized in this function [-Wmaybe-uninitialized]

> This is because in the pcf8563_get_alarm_mode() function, we
> check any nonzero return of pcf8563_read_block_data, but
> in the irq function we only check for negative values, so
> a possible positive value does not get detected if the compiler
> chooses not to inline the entire call chain.

> Checking for any non-zero value in the interrupt handler as well
> is just as correct and lets the compiler know what we are doing,
> without needing a bogus initialization.

> As pointed out by Sergei Shtylyov, the same code section contains
> another bug: an interrupt handler is not supposed to return
> an errno value. Let's fix this as well by returning IRQ_NONE
> in case of a communication error.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

    If you're fixing both issues in one patch, it probably needs somewhat 
modified subject, like "rtc: pcf8356: fix error handling".

WBR, Sergei
