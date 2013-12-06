From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 6 Dec 2013 15:40:06 +0000
Subject: [PATCH v5 2/3] regulator: tps6586x: add and use correct voltage
 table
In-Reply-To: <7c948660cda4684d28fa97f82295ab84f6ef658e.1386333697.git.stefan@agner.ch>
References: <cover.1386333697.git.stefan@agner.ch>
 <7c948660cda4684d28fa97f82295ab84f6ef658e.1386333697.git.stefan@agner.ch>
Message-ID: <20131206154006.GE23519@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 06 Dec 2013, Stefan Agner wrote:

> Depending on the regulator version, the voltage table might be
> different. Use version specific regulator tables in order to select
> correct voltage table. For the following regulator versions different
> voltage tables are now used:
> 
>   * TPS658623: Use correct voltage table for SM2
>   * TPS658643: New voltage table for SM2
> 
> Both versions are in use on the Colibri T20 module. Make use of the
> correct tables by requesting the correct SM2 voltage of 1.8V.
> 
> This change is not backward compatible since an old driver is not able
> to correctly set that value. The value 1.8V is out of range for the old
> driver and will refuse to probe the device. The regulator starts with
> default settings and the driver shows appropriate error messages.
> 
> On Colibri T20, the old value used to work with TPS658623 since the
> driver applied a wrong voltage table too. However, the TPS658643 used
> on V1.2 devices uses yet another voltage table and those broke that
> pseudo-compatibility. The regulator driver now has the correct voltage
> table for both regulator versions and those the correct voltage can be
> used in the device tree.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes since v3:
>   - Check if version specific table is necessary
> 
> Changes since v2:
>   - Removed reg_ from reg_version
>   - Moved walk through version dependent tables to find_regulator_info,
>     removed the inline definition. This reduces .o size and encapsulates
>     the logic of finding the right regulator into one function. It comes
>     with a slight code duplication, the table search now appears twice.
> ---
>  arch/arm/boot/dts/tegra20-colibri-512.dtsi |  4 +-
>  drivers/regulator/tps6586x-regulator.c     | 93 ++++++++++++++++++++++++-----

Applied with Reviews and Acks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
