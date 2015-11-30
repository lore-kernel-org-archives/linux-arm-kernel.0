From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 30 Nov 2015 15:51:56 -0800
Subject: [PATCH 2/3] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
 (Alexander Aring's message of "Thu, 19 Nov 2015 19:08:09 +0100")
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
 <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
Message-ID: <7hr3j782qr.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Aring <alex.aring@gmail.com> writes:

> This patch adds support for RPi several Power Domains and enable support
> to enable the USB Power Domain when it's not enabled before.
>
> This patch based on Eric Anholt's patch to support Power Domains. He had
> an issue about -EPROBE_DEFER inside the power domain subsystem, this
> issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
> if we fail to init or turn-on domain").

[...]

> +#define RPI_POWER_DOMAIN(_domain, _name)			\
> +	[_domain] = {						\

Using _domain as the array index is going to create a sparsely filled
array here, wasting memory.   I'm not sure what the other domain numbers
are for other domains to know if this is a big waste or not, but it's
still a bit wasteful.

In any case, AFAICT, it doesn't look like you need to have the array
index match the domain number anyways since you're using container_of().

So I suggest just removing this array index part, and just creating them
in arrary order.  Then your _probe function isn't going to try to setup
3 non-enabled domains before it finally hits the USB domain.

Kevin
