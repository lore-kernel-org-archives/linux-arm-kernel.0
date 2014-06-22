From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Jun 2014 14:14:52 +0100
Subject: [PATCH v3 1/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <1402404197-4236-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1402404197-4236-1-git-send-email-clabbe.montjoie@gmail.com>
 <1402404197-4236-2-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20140622131452.GF32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 02:43:14PM +0200, LABBE Corentin wrote:
> +int sunxi_aes_poll(struct ablkcipher_request *areq)
> +{
...
> +	if (areq->src == NULL || areq->dst == NULL) {
> +		dev_err(ss->dev, "ERROR: Some SGs are NULL %u\n", areq->nbytes);
> +		return -1;

You return -1 from here quite frequently.  Have you verified that there
is no way for this return value to get to userspace?

Even if it can't get to userspace now, what if someone modifies the code
so it can be returned?

I detest crap that's written with "return -1" in it because it looks like
there is no care with the established error handling semantics for the
kernel (small negative numbers are errno codes.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
