From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 17 Jan 2014 09:46:08 +0000
Subject: [PATCH RFC 1/6] net: rfkill: gpio: fix gpio name buffer size
 off by 1
In-Reply-To: <1389941251-32692-2-git-send-email-wens@csie.org>
References: <1389941251-32692-1-git-send-email-wens@csie.org>
 <1389941251-32692-2-git-send-email-wens@csie.org>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D45EA9D@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai
> snprintf should be passed the complete size of the buffer, including
> the space for '\0'. The previous code resulted in the *_reset and
> *_shutdown strings being truncated.
...
> diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
...
> -	snprintf(rfkill->reset_name, len + 6 , "%s_reset", rfkill->name);
> -	snprintf(rfkill->shutdown_name, len + 9, "%s_shutdown", rfkill->name);
> +	snprintf(rfkill->reset_name, len + 7 , "%s_reset", rfkill->name);
> +	snprintf(rfkill->shutdown_name, len + 10, "%s_shutdown", rfkill->name);

I can't find the context for the above, but they look very dubious.
I'd expect: snprintf(foo, sizeof foo, ...).
If you are trying to truncate rfkill->name you need to use %.*s.

	David
