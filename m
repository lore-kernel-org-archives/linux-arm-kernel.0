From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 13 Apr 2018 13:08:35 +0200
Subject: [PATCH] thermal/drivers/exynos_tmu: Fix warnings in
 temp_to_code / code_to_temp
In-Reply-To: <1523617209-1730-1-git-send-email-daniel.lezcano@linaro.org>
References: <10298074.ogKH1ypqfx@amdc3058>
 <CGME20180413110032epcas4p3e0ef781eecb771b1294b7992d2ee6e6d@epcas4p3.samsung.com>
 <1523617209-1730-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <11044079.DdDvlFD91s@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 13, 2018 01:00:09 PM Daniel Lezcano wrote:
> The latest driver cleanup introduced a compilation warning
> 
>  drivers/thermal/samsung/exynos_tmu.c: In function ?exynos_get_temp?:
>  drivers/thermal/samsung/exynos_tmu.c:931:37: warning: ?temp? may be used uninitialized in this function [-Wmaybe-uninitialized]
>    *temp = code_to_temp(data, value) * MCELSIUS;
>                                         ^
> 
>  drivers/thermal/samsung/exynos_tmu.c: In function ?temp_to_code?
>  drivers/thermal/samsung/exynos_tmu.c:304:9: warning: ?temp_code? may be used uninitialized in this function [-Wmaybe-uninitialized]
> 					  return temp_code;
> 					           ^~~~~~~~~
> 
> The compiler gives a warning because semantically speaking the
> function has no default value. However the code path, were the
> variable is never initialized is a dead branch because the switch
> statement always choose one of the two cases as the data->cal_type is
> initialized in the init function to one of both values.
> 
> This is unclear as it adds a dependency on the initialization function
> and it is prone to error. Make things clearer by converting the
> functions with if ... return statements, thus showing we are expecting
> the values to be correctly filled before calling this function.
> 
> This change fixes the couple of function warnings.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks Daniel, this is much better fix.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 46 ++++++++++--------------------------
>  1 file changed, 12 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 2ec8548..197f267 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -284,24 +284,13 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
>   */
>  static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
>  {
> -	int temp_code;
> -
> -	switch (data->cal_type) {
> -	case TYPE_TWO_POINT_TRIMMING:
> -		temp_code = (temp - EXYNOS_FIRST_POINT_TRIM) *
> -			(data->temp_error2 - data->temp_error1) /
> -			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
> -			data->temp_error1;
> -		break;
> -	case TYPE_ONE_POINT_TRIMMING:
> -		temp_code = temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
> -		break;
> -	default:
> -		WARN_ON(1);
> -		break;
> -	}
> +	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
> +		return temp + data->temp_error1 - EXYNOS_FIRST_POINT_TRIM;
>  
> -	return temp_code;
> +	return (temp - EXYNOS_FIRST_POINT_TRIM) *
> +		(data->temp_error2 - data->temp_error1) /
> +		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) +
> +		data->temp_error1;
>  }
>  
>  /*
> @@ -310,24 +299,13 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
>   */
>  static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
>  {
> -	int temp;
> -
> -	switch (data->cal_type) {
> -	case TYPE_TWO_POINT_TRIMMING:
> -		temp = (temp_code - data->temp_error1) *
> -			(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
> -			(data->temp_error2 - data->temp_error1) +
> -			EXYNOS_FIRST_POINT_TRIM;
> -		break;
> -	case TYPE_ONE_POINT_TRIMMING:
> -		temp = temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
> -		break;
> -	default:
> -		WARN_ON(1);
> -		break;
> -	}
> +	if (data->cal_type == TYPE_ONE_POINT_TRIMMING)
> +		return temp_code - data->temp_error1 + EXYNOS_FIRST_POINT_TRIM;
>  
> -	return temp;
> +	return (temp_code - data->temp_error1) *
> +		(EXYNOS_SECOND_POINT_TRIM - EXYNOS_FIRST_POINT_TRIM) /
> +		(data->temp_error2 - data->temp_error1) +
> +		EXYNOS_FIRST_POINT_TRIM;
>  }
>  
>  static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
