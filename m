From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 25 Aug 2014 12:15:23 +0200
Subject: [PATCH] PWM: atmel: fix incorrect CDTY value after enabling or
 disabling
In-Reply-To: <1394823931-2815-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394823931-2815-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140825101522.GA16960@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 08:05:31PM +0100, Alexandre Belloni wrote:
> pwm-leds calls .config() and .disable() in a row. This exhibits that it may
> happen that the channel gets disabled before CDTY has been updated with CUPD.
> The issue gets quite worse with long periods.
> So, ensure by reading ISR that at least one period has past before disabling the
> channel.
> 
> The other issue is that it may happen that CUPD is not flushed before enabling
> the channel so it will update CDTY/CPRD just after one period. So we always set
> CUPD, even when the channel is not enabled.
> 
> Tested on at91sam9g45 and sama5d31ek.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/pwm/pwm-atmel.c | 46 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 17 deletions(-)

Hi Alexandre,

going through the list of unapplied patches I came across this old
patch. It was never reviewed nor acked by anyone and you didn't ping me,
so I always assumed it must no longer be required. Is that so?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140825/98b64092/attachment.sig>
