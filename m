From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 06 Oct 2011 22:44:32 +0200
Subject: [PATCHv2] hw_random: add driver for atmel true hardware random
	number generator
In-Reply-To: <20111006203023.GE24034@tarshish> (Baruch Siach's message of
	"Thu, 6 Oct 2011 22:30:23 +0200")
References: <1317923791-31200-1-git-send-email-jacmet@sunsite.dk>
	<20111006203023.GE24034@tarshish>
Message-ID: <87ty7l3l5b.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Baruch" == Baruch Siach <baruch@tkos.co.il> writes:

Hi,

 >> +static int atmel_trng_read(struct hwrng *rng, void *buf, size_t max,
 >> +			   bool wait)
 >> +{
 >> +	struct atmel_trng *trng = container_of(rng, struct atmel_trng, rng);
 >> +	u32 *data = buf;
 >> +
 >> +	/* data ready? */
 >> +	if (readl(trng->base + TRNG_ODATA) & 1) {
 >> +		*data = readl(trng->base + TRNG_ODATA);
 >> +		return 4;

 Baruch> Shouldn't you check for max >= 4 before writing to *buf?

Conceptually, yes. The other hw_random drivers don't seem to do it
though, and the buffer size is guaranteed to be atleast 32 bytes, but I
can stick a '&& max >= 4' in the conditional if you prefer.

-- 
Bye, Peter Korsgaard
