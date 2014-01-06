From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 06 Jan 2014 19:51:46 +0100
Subject: [PATCH v5 1/3] usb: ohci-at91: replace request_mem_region +
 ioremap by devm_ioremap_resource
In-Reply-To: <CAOesGMhtg0vqVaRekfCE3-RZL644xEWBn4oVN22DtZR6L5WTxw@mail.gmail.com>
References: <1386579115-4324-1-git-send-email-b.brezillon@overkiz.com>	<1386579115-4324-2-git-send-email-b.brezillon@overkiz.com>
 <CAOesGMhtg0vqVaRekfCE3-RZL644xEWBn4oVN22DtZR6L5WTxw@mail.gmail.com>
Message-ID: <52CAFB42.1060501@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof,

On 06/01/2014 19:08, Olof Johansson wrote:
> Boris,
>
> On Mon, Dec 9, 2013 at 12:51 AM, Boris BREZILLON
> <b.brezillon@overkiz.com> wrote:
>> Replace the request_mem_region + ioremap calls by the
>> devm_ioremap_resource call which does the same things but with device
>> managed resources.
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Did you build these patches?

Yes, I did.

> There's several breakages due to them in
> last night's next. I'm a little puzzled how they passed testing before
> you submitted?
> This one fails with:
>
> drivers/usb/host/ohci-at91.c: In function 'usb_hcd_at91_probe':
> drivers/usb/host/ohci-at91.c:157:36: error: 'dev' undeclared (first
> use in this function)
>    hcd->regs = devm_ioremap_resource(dev, res);
>                                      ^
> drivers/usb/host/ohci-at91.c:157:36: note: each undeclared identifier
> is reported only once for each function it appears in
> drivers/usb/host/ohci-at91.c:157:41: error: 'res' undeclared (first
> use in this function)
>    hcd->regs = devm_ioremap_resource(dev, res);

Actually this patch series depends on another patch :
"usb: ohci-at91: fix irq and iomem resource retrieval"
commit fb5f1834c3221e459324c6885eaad75429f722a5.

This patch was taken out to ease integration in 3.13-rc5.

Sorry, I should have stated it in my cover letter.

Which next are you using ?
I took a look at linux-next and the dev variable is declared.

> There are more too, the original one I was bisecting for was the below
> one, but the above hit first:
>
> drivers/usb/host/ohci-at91.c: In function 'usb_hcd_at91_probe':
> drivers/usb/host/ohci-at91.c:190:4: error: label 'err' used but not defined
> drivers/usb/host/ohci-at91.c: At top level:
> drivers/usb/host/ohci-at91.c:206:2: warning: data definition has no
> type or storage class [enabled by default]
> drivers/usb/host/ohci-at91.c:206:2: error: type defaults to 'int' in
> declaration of 'at91_stop_hc' [-Werror=implicit-int]
> drivers/usb/host/ohci-at91.c:206:2: warning: parameter names (without
> types) in function declaration [enabled by default]
> drivers/usb/host/ohci-at91.c:206:2: error: conflicting types for 'at91_stop_hc'
> drivers/usb/host/ohci-at91.c:97:13: note: previous definition of
> 'at91_stop_hc' was here
> drivers/usb/host/ohci-at91.c:208:5: error: expected '=', ',', ';',
> 'asm' or '__attribute__' before ':' token
> drivers/usb/host/ohci-at91.c:210:2: error: expected identifier or '('
> before 'return'
> drivers/usb/host/ohci-at91.c:211:1: error: expected identifier or '('
> before '}' token
> drivers/usb/host/ohci-at91.c:97:13: warning: 'at91_stop_hc' defined
> but not used [-Wunused-function]
>   static void at91_stop_hc(struct platform_device *pdev)

These errors come from merge commit 
99f14bd4d1b2a1b1b6cd508e08efdbc5e3919198.

There is a missing brace on the last retval test.

Best Regards,

Boris
> Somewhat spectacular.  Greg, can you please drop these until he's
> sorted out his submission? :(
>
>
> -Olof
