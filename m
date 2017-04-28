From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 28 Apr 2017 11:37:41 +0100
Subject: [PATCH v2 1/2] [media] rc-core: Add inlined stubs for core rc_*
 functions
In-Reply-To: <20170412153956.13329-1-lee.jones@linaro.org>
References: <20170412153956.13329-1-lee.jones@linaro.org>
Message-ID: <20170428103741.csvcznnxkk4xkqmj@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Apr 2017, Lee Jones wrote:

> Currently users have to use all sorts of ugly #ifery within
> their drivers in order to avoid linking issues at build time.
> This patch allows users to safely call these functions when
> !CONFIG_RC_CORE and make decisions based on the return value
> instead.  This is a much more common and clean way of doing
> things within the Linux kernel.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v1 => v2
>   - Use '#if IF_ENABLED()' instead of '#ifdef' in order to do the
>     right thing, even when CONFIG_RC_CORE=m.
>   
> include/media/rc-core.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Hans,

What are your plans for this patch set?  Removal of #ifery from C
files has to be seen as an improvement, thus I see no reason why they
wouldn't be accepted.

Please advise.

> diff --git a/include/media/rc-core.h b/include/media/rc-core.h
> index 73ddd721..f176a9e 100644
> --- a/include/media/rc-core.h
> +++ b/include/media/rc-core.h
> @@ -209,7 +209,14 @@ struct rc_dev {
>   * @rc_driver_type: specifies the type of the RC output to be allocated
>   * returns a pointer to struct rc_dev.
>   */
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  struct rc_dev *rc_allocate_device(enum rc_driver_type);
> +#else
> +static inline struct rc_dev *rc_allocate_device(int unused)
> +{
> +	return NULL;
> +}
> +#endif
>  
>  /**
>   * devm_rc_allocate_device - Managed RC device allocation
> @@ -218,21 +225,42 @@ struct rc_dev *rc_allocate_device(enum rc_driver_type);
>   * @rc_driver_type: specifies the type of the RC output to be allocated
>   * returns a pointer to struct rc_dev.
>   */
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  struct rc_dev *devm_rc_allocate_device(struct device *dev, enum rc_driver_type);
> +#else
> +static inline struct rc_dev *devm_rc_allocate_device(struct device *dev, int unused)
> +{
> +	return NULL;
> +}
> +#endif
>  
>  /**
>   * rc_free_device - Frees a RC device
>   *
>   * @dev: pointer to struct rc_dev.
>   */
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  void rc_free_device(struct rc_dev *dev);
> +#else
> +static inline void rc_free_device(struct rc_dev *dev)
> +{
> +	return;
> +}
> +#endif
>  
>  /**
>   * rc_register_device - Registers a RC device
>   *
>   * @dev: pointer to struct rc_dev.
>   */
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  int rc_register_device(struct rc_dev *dev);
> +#else
> +static inline int rc_register_device(struct rc_dev *dev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>  
>  /**
>   * devm_rc_register_device - Manageded registering of a RC device
> @@ -240,14 +268,28 @@ int rc_register_device(struct rc_dev *dev);
>   * @parent: pointer to struct device.
>   * @dev: pointer to struct rc_dev.
>   */
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  int devm_rc_register_device(struct device *parent, struct rc_dev *dev);
> +#else
> +static inline int devm_rc_register_device(struct device *parent, struct rc_dev *dev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>  
>  /**
>   * rc_unregister_device - Unregisters a RC device
>   *
>   * @dev: pointer to struct rc_dev.
>   */
> +#if IS_ENABLED(CONFIG_RC_CORE)
>  void rc_unregister_device(struct rc_dev *dev);
> +#else
> +static inline void rc_unregister_device(struct rc_dev *dev)
> +{
> +	return;
> +}
> +#endif
>  
>  /**
>   * rc_open - Opens a RC device

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
