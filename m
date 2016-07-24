From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Jul 2016 21:48:55 +0200
Subject: [PATCH v5 12/15] binfmt_flat: allow compressed flat binary format
 to work on MMU systems
In-Reply-To: <1469374229-21585-13-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
 <1469374229-21585-13-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <4262519.L4vdOGcrh0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, July 24, 2016 11:30:26 AM CEST Nicolas Pitre wrote:
> +#else
> +                       /*
> +                        * This is used on MMU systems mainly for testing.
> +                        * Let's use a kernel buffer to simplify things.
> +                        */
> +                       long unz_text_len = text_len - sizeof(struct flat_hdr);
> +                       long unz_len = unz_text_len + full_data;
> +                       char *unz_data = vmalloc(unz_len);
> +                       if (!unz_data) {
> +                               result = -ENOMEM;
> 

Is there a risk of a malicious user exhausting vmalloc space with a
binary that has forged headers? If there is, maybe put an upper bound on
the size of allocation.

More broadly speaking, are there any other attacks that may get enabled
through forged binaries? We've had a couple of vulnerabilities in
binfmt_elf over the years, and I wonder how dangerous it might be
if distros turn on binfmt_flat support by default.

	Arnd
