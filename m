From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Jun 2013 16:00:19 -0600
Subject: [PATCH v1 10/12] input: keypad_matrix: use usleep_range() for
 scan delay
In-Reply-To: <1371838198-7327-11-git-send-email-gsi@denx.de>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-11-git-send-email-gsi@denx.de>
Message-ID: <51C4CCF3.20603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> querying keyboards isn't a time critical task and does not depend on
> exact timing in the microseconds order -- the timeouts and delays are
> arbitrary choices or educated guesses at best anyway

> diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt

> @@ -93,7 +93,10 @@ Optional Properties:
>  			a column line and reading back its row status,
>  			such that pin levels can settle after
>  			propagating through the matrix and its
> -			associated hardware components
> +			associated hardware components, can be specified
> +			with either one value giving the exact delay, or
> +			with two values giving a delay range (allowing
> +			for reduced timer management overhead)
>  - col-switch-delay-ms:	columns switch interval in milliseconds instead
>  			of using interrupts to detect key press changes,
>  			enables polling mode when specified
> @@ -146,7 +149,7 @@ Examples:
>  	matrix_keypad {
>  		compatible = "gpio-matrix-keypad";
>  		debounce-delay-ms = <5>;
> -		col-scan-delay-us = <1>;
> +		col-scan-delay-us = <2 10>;

Is it really useful to change the binding this way?

The values in DT presumably represent the minimum delays that the HW
will tolerate or that are useful. SW is always free to scan more slowly
than that. As such, if you're simply modifying the driver to allow more
flexibility in timing, then I don't think you have to modify the DT
binding to allow for this?
