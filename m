From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Nov 2015 16:12:07 +0000
Subject: [PATCH 2/2] serial: amba-pl011: abstract register accessors
In-Reply-To: <1446562867-5693-2-git-send-email-timur@codeaurora.org>
References: <1446562867-5693-1-git-send-email-timur@codeaurora.org>
 <1446562867-5693-2-git-send-email-timur@codeaurora.org>
Message-ID: <20151103161206.GA8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 09:01:07AM -0600, Timur Tabi wrote:
> Finally, note that pl011_putc() is untouched, because that function
> does not have access to the 'uap' object.  A separate mechanism
> is needed to switch accessors in that function.

Thanks for pointing that out... that's a mistake in my patches.  It's
very difficult to see how we could ever support earlyconsole on ZTE
without massively overhauling the earlycon stuff.  I'll undo the
changes there in my series.

Now, as for this patch...

>  	unsigned int (*get_fifosize)(struct amba_device *dev);
> +	u16 (*regreadw)(const void __iomem *addr);
> +	void (*regwritew)(u16 val, void __iomem *addr);
> +	void (*regwriteb)(u8 val, void __iomem *addr);

regwriteb() is used nowhere in this patch.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
