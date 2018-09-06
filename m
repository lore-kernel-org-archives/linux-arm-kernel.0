From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Sep 2018 17:53:14 +0100
Subject: [PATCH v2 2/9] ARM: signal: always use __copy_to_user to save
 iwmmxt context
In-Reply-To: <1536251888-8302-3-git-send-email-julien.thierry@arm.com>
References: <1536251888-8302-1-git-send-email-julien.thierry@arm.com>
 <1536251888-8302-3-git-send-email-julien.thierry@arm.com>
Message-ID: <20180906165314.GR30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 05:38:01PM +0100, Julien Thierry wrote:
> @@ -86,10 +84,14 @@ static int preserve_iwmmxt_context(struct iwmmxt_sigframe __user *frame)
>  		 * Set the magic and size appropriately so that properly
>  		 * written userspace can skip it reliably:
>  		 */
> -		__put_user_error(DUMMY_MAGIC, &frame->magic, err);
> -		__put_user_error(IWMMXT_STORAGE_SIZE, &frame->size, err);
> +		*kframe = (struct iwmmxt_sigframe) {
> +			.magic = DUMMY_MAGIC,
> +			.size  = IWMMXT_STORAGE_SIZE,
> +		};
>  	}
>  
> +	err = __copy_to_user(frame, kframe, sizeof(*kframe));

Looks safe to me - iwmmxt_sigframe is ultimately made up of
unsigned long's and unsigned int's and the embedded struct
iwmmxt_struct is aligned to an 8 byte boundary anyway, so there
should be no padding here either.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
