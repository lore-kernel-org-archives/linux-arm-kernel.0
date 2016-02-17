From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 17 Feb 2016 09:00:36 +0900
Subject: [PATCH] regulator: s5m8767: fix get_register() error handling
In-Reply-To: <1455634402-1997203-1-git-send-email-arnd@arndb.de>
References: <1455634402-1997203-1-git-send-email-arnd@arndb.de>
Message-ID: <56C3B824.9010808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.02.2016 23:53, Arnd Bergmann wrote:
> The s5m8767_pmic_probe() function calls s5m8767_get_register() to
> read data without checking the return code, which produces a compile-time
> warning when that data is accessed:
> 
> drivers/regulator/s5m8767.c: In function 's5m8767_pmic_probe':
> drivers/regulator/s5m8767.c:924:7: error: 'enable_reg' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> drivers/regulator/s5m8767.c:944:30: error: 'enable_val' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This changes the s5m8767_get_register() function to return a -EINVAL
> not just for an invalid register number but also for an invalid
> regulator number, as both would result in returning uninitialized
> data. The s5m8767_pmic_probe() function is then changed accordingly
> to fail on a read error, as all the other callers of s5m8767_get_register()
> already do.
> 
> In practice this probably cannot happen, as we don't call
> s5m8767_get_register() with invalid arguments, but the gcc
> warning seems valid in principle, in terms writing safe
> error checking.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 9c4c60554acf ("regulator: s5m8767: Convert to use regulator_[enable|disable|is_enabled]_regmap")
> ---
>  drivers/regulator/s5m8767.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
