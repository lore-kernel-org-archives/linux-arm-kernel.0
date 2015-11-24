From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 24 Nov 2015 11:18:01 +0000
Subject: [Xen-devel] [PATCH v3 24/62] arm: Introduce a generic way to
 use a device from acpi
In-Reply-To: <1447753261-7552-25-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-25-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511241110360.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> Add generic way to use device from acpi similar to the way it is
> supported in device tree.
> 
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  xen/arch/arm/device.c        | 19 +++++++++++++++++++
>  xen/arch/arm/xen.lds.S       |  7 +++++++
>  xen/include/asm-arm/device.h | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/xen/arch/arm/device.c b/xen/arch/arm/device.c
> index 0b53f6a..5494de0 100644
> --- a/xen/arch/arm/device.c
> +++ b/xen/arch/arm/device.c
> @@ -22,6 +22,7 @@
>  #include <xen/lib.h>
>  
>  extern const struct device_desc _sdevice[], _edevice[];
> +extern const struct acpi_device_desc _asdevice[], _aedevice[];
>  
>  int __init device_init(struct dt_device_node *dev, enum device_class class,
>                         const void *data)
> @@ -50,6 +51,24 @@ int __init device_init(struct dt_device_node *dev, enum device_class class,
>      return -EBADF;
>  }
>  
> +int __init acpi_device_init(enum device_class class, const void *data, int class_type)
> +{
> +    const struct acpi_device_desc *desc;
> +
> +    for ( desc = _asdevice; desc != _aedevice; desc++ )
> +    {
> +        if ( ( desc->class != class ) && ( desc->class_type != class_type ) )
> +            continue;

Shouldn't this be

  if ( ( desc->class != class ) || ( desc->class_type != class_type ) )

?

> +
> +        ASSERT(desc->init != NULL);
> +
> +        return desc->init(data);
> +    }
> +
> +    return -EBADF;
> +}
> +
>  enum device_class device_get_class(const struct dt_device_node *dev)
>  {
>      const struct device_desc *desc;
> diff --git a/xen/arch/arm/xen.lds.S b/xen/arch/arm/xen.lds.S
> index 0488f37..60802f6 100644
> --- a/xen/arch/arm/xen.lds.S
> +++ b/xen/arch/arm/xen.lds.S
> @@ -100,6 +100,13 @@ SECTIONS
>        _edevice = .;
>    } :text
>  
> +  . = ALIGN(8);
> +  .adev.info : {
> +      _asdevice = .;
> +      *(.adev.info)
> +      _aedevice = .;
> +  } :text
> +
>    . = ALIGN(PAGE_SIZE);             /* Init code and data */
>    __init_begin = .;
>    .init.text : {
> diff --git a/xen/include/asm-arm/device.h b/xen/include/asm-arm/device.h
> index 5d0a4cd..085f221 100644
> --- a/xen/include/asm-arm/device.h
> +++ b/xen/include/asm-arm/device.h
> @@ -50,6 +50,27 @@ struct device_desc {
>      int (*init)(struct dt_device_node *dev, const void *data);
>  };
>  
> +struct acpi_device_desc {
> +    /* Device name */
> +    const char *name;
> +    /* Device class */
> +    enum device_class class;
> +    /* type of device supported by the driver */
> +    const int class_type;
> +    /* Device initialization */
> +    int (*init)(const void *data);
> +};
> +
> +/**
> + *  acpi_device_init - Initialize a device
> + *  @class: class of the device (serial, network...)
> + *  @data: specific data for initializing the device
> + *
> + *  Return 0 on success.
> + */
> +int __init acpi_device_init(enum device_class class,
> +                            const void *data, int class_type);
> +
>  /**
>   *  device_init - Initialize a device
>   *  @dev: device to initialize
> @@ -78,6 +99,15 @@ __section(".dev.info") = {                                          \
>  #define DT_DEVICE_END                                               \
>  };
>  
> +#define ACPI_DEVICE_START(_name, _namestr, _class)                    \
> +static const struct acpi_device_desc __dev_desc_##_name __used           \
> +__attribute__((__section__(".adev.info"))) = {                       \

why __attribute__?


> +    .name = _namestr,                                               \
> +    .class = _class,                                                \
> +
> +#define ACPI_DEVICE_END                                               \
> +};
> +
>  #endif /* __ASM_ARM_DEVICE_H */
>  
>  /*
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
> 
