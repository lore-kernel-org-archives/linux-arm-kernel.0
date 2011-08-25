From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Aug 2011 20:15:01 +0100
Subject: [PATCH]arm: nwfpe: '&pointer[0]' to 'pointer' fix
In-Reply-To: <20110825191143.GA3149@maxin>
References: <20110825191143.GA3149@maxin>
Message-ID: <20110825191501.GA4488@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 10:11:43PM +0300, Maxin B. John wrote:
> '&pointer[0]' to 'pointer' fix in arch/arm/nwfpe/fpa11_cpdt.c 

Your reason being?

>  #ifdef __ARMEB__
> -	get_user(p[0], &pMem[0]);	/* sign & exponent */
> +	get_user(p[0], pMem);	/* sign & exponent */
>  	get_user(p[1], &pMem[1]);

You may notice the original code has some consistency.  Your replacement
is less consistent.  If you wish to make this change, it should change to:

	get_user(p[0], pMem + 0);
	get_user(p[1], pMem + 1);

to maintain consistency.
