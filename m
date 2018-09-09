From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 9 Sep 2018 13:13:25 +0200
Subject: [PATCH RFC 3/5] coccinelle: add xxxsetbitsXX converting spatch
In-Reply-To: <1536349307-20714-4-git-send-email-clabbe@baylibre.com>
References: <1536349307-20714-4-git-send-email-clabbe@baylibre.com>
Message-ID: <463dbbdc-7afc-bee8-8da1-bbe70b4aec26@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

How do you think about to add any more meta-data for this semantic patch script?

* SPDX identifier
* Copyright information
* Confidence level

https://bottest.wiki.kernel.org/coccicheck


> +virtual context

Further variables will be needed if you would like to use corresponding
operation modes (besides ?patch?).


> +expression reg;
> +expression set;
> +expression clear;

I propose once more to avoid the repetition of (unnecessary) SmPL code.
This part could be written like the following instead.

+expression clear, set, reg;


If you would increase the usage of SmPL disjunctions, the specification
of duplicate SmPL code could be reduced considerably.

* Would you like to merge SmPL rules based on the distinction between
  the data types ?u32? and ?u64??

* Did you identify any optional code in this transformation approach?


> +@@
> +expression base;
> +expression offset;
> +expression value;
> +@@
> +
> +- mtu3_setbits(base, offset, value);
> ++ setbits32(base + offset, value);
> +
> +@@
> +expression base;
> +expression offset;
> +expression mask;
> +@@
> +
> +- mtu3_clrbits(base, offset, mask);
> ++ clrbits32(base + offset, mask);

Another update suggestion:

+ at replacement@
+expression base, offset;
+@@
+(
+-mtu3_clrbits
++clrbits32
+|
+-mtu3_setbits
++setbits32
+)(base
+-     ,
++ +
+  offset, ...);


Would you like to try further software fine-tuning out?

Regards,
Markus
