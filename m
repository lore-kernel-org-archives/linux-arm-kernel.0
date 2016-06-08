From: slash.tmp@free.fr (Mason)
Date: Wed, 8 Jun 2016 09:56:11 +0200
Subject: [PATCH] cpufreq: mvebu: fix integer to pointer cast
In-Reply-To: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <5757CF9B.3080402@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2016 13:30, Ben Dooks wrote:

> Fix the use of 0 instead of NULL to clk_get() call. This stops the
> following warning:
> 
> drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer

May I ask which compiler/version produced that diagnostic?


> -		clk = clk_get(cpu_dev, 0);
> +		clk = clk_get(cpu_dev, NULL);

Quoting C99 6.3.2.3 Pointers clause 3

> An integer constant expression with the value 0, or such an expression cast to type
> void *, is called a null pointer constant. If a null pointer constant is converted to a
> pointer type, the resulting pointer, called a null pointer, is guaranteed to compare unequal
> to a pointer to any object or function.

In fact, some implementations merely #define NULL 0
(which, admittedly, creates problems when NULL is used as a parameter
to variadic functions)

Regards.
