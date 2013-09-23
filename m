From: tim.gardner@canonical.com (Tim Gardner)
Date: Mon, 23 Sep 2013 14:10:27 -0700
Subject: [PATCH] TTY: hvc_dcc: probe for a JTAG connection before
 registering
In-Reply-To: <1379968234-23373-1-git-send-email-robherring2@gmail.com>
References: <1379968234-23373-1-git-send-email-robherring2@gmail.com>
Message-ID: <5240AE43.6070708@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2013 01:30 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Enabling the ARM DCC console and using without a JTAG connection will
> simply hang the system. Since distros like to turn on all options, this
> is a reoccurring problem to debug. We can do better by checking if
> anything is attached and handling characters. There is no way to probe
> this, so send a newline and check that it is handled.
> 
> Cc: Paolo Pisati <paolo.pisati@canonical.com>
> Cc: Tim Gardner <tim.gardner@canonical.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  drivers/tty/hvc/hvc_dcc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/tty/hvc/hvc_dcc.c b/drivers/tty/hvc/hvc_dcc.c
> index 44fbeba..44c8aff 100644
> --- a/drivers/tty/hvc/hvc_dcc.c
> +++ b/drivers/tty/hvc/hvc_dcc.c
> @@ -86,6 +86,21 @@ static int hvc_dcc_get_chars(uint32_t vt, char *buf, int count)
>  	return i;
>  }
>  
> +static bool hvc_dcc_check(void)
> +{
> +	unsigned long time = jiffies;
> +
> +	/* Write a test character to check if it is handled */
> +	__dcc_putchar('\n');
> +
> +	while (jiffies < time + (HZ / 10)) {
> +		if (!(__dcc_getstatus() & DCC_STATUS_TX))
> +			return true;
> +	}

I think you should use one of the jiffies time comparison functions, e.g.,

	time = jiffies + (HZ / 10);
	while (time_before(jiffies,time) {
		...
	}

What is the possibility that __dcc_getstatus() will return garbage if no
JTAG is connected ? In that event you're likely to get a false positive
on DCC_STATUS_TX.

rtg


-- 
Tim Gardner tim.gardner at canonical.com
