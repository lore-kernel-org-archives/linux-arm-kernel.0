From: akpm@linux-foundation.org (Andrew Morton)
Date: Wed, 8 May 2013 13:50:29 -0700
Subject: [PATCH -v8 11/11] Move arch/x86 reboot= handling to generic
 kernel.
In-Reply-To: <1367937595-32241-12-git-send-email-holt@sgi.com>
References: <1367937595-32241-1-git-send-email-holt@sgi.com>
 <1367937595-32241-12-git-send-email-holt@sgi.com>
Message-ID: <20130508135029.ffbeefa6b8154bee31e7bbbe@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  7 May 2013 09:39:55 -0500 Robin Holt <holt@sgi.com> wrote:

> Merge together the unicore32, arm, and x86 reboot= command line
> parameter handling.
> 
> ...
>
> +static int __init reboot_setup(char *str)
> +{
> +	for (;;) {
> +		/*
> +		 * Having anything passed on the command line via
> +		 * reboot= will cause us to disable DMI checking
> +		 * below.
> +		 */
> +		reboot_default = 0;
> +
> +		switch (*str) {
> +#if defined(CONFIG_X86) || defined(CONFIG_X86_64)
> +		case 'w':
> +			reboot_mode = REBOOT_WARM;
> +			break;
> +
> +		case 'c':
> +			reboot_mode = REBOOT_COLD;
> +			break;
> +
> +#ifdef CONFIG_SMP
> +		case 's':
> +			if (isdigit(*(str+1))) {
> +				reboot_cpu = (int) (*(str+1) - '0');
> +				if (isdigit(*(str+2)))
> +					reboot_cpu = reboot_cpu*10 + (int)(*(str+2) - '0');
> +			}

Boy, that's some weird stuff.

What's wrong with doing

			if (isdigit(str[1])) {
				reboot_cpu = str[1] - '0';
				if (isdigit(str[2]))
					reboot_cpu = reboot_cpu * 10 +
							str[2] - '0';
			}

?

But it's still nonsense - we should eliminate its
you-have-less-than-101-CPUs restriction by using, you know, atoi().
