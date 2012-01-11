From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Jan 2012 16:55:08 +0000
Subject: [PATCH 5/7] at91 : fix dirty hack for the selfrefresh function
In-Reply-To: <1326293740-15735-6-git-send-email-daniel.lezcano@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
 <1326293740-15735-6-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20120111165508.GC1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 03:55:38PM +0100, Daniel Lezcano wrote:
> Remove the static variable saved_lpr1 defined in the header and
> define a structure to be common with all the functions.
> That will cleanly unify the function definitions.

I don't think this is in any way a correct way to do things.

> +	struct ram_saved rs;
> @@ -49,9 +49,9 @@ static int at91_enter_idle(struct cpuidle_device *dev,
>  	else if (index == 1) {
>  		asm("b 1f; .align 5; 1:");
>  		asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */
> -		saved_lpr = sdram_selfrefresh_enable();
> +		sdram_selfrefresh_enable(&rs);

What's the point of draining the write buffer if you then pass a buffer
to this function to write data to?

If the requirement is that the write buffer is drained before issue a
wait-for-interrupt instruction (in cpu_do_idle()) then this code
violates that.

That's why I went on in my discussion to a second solution.
