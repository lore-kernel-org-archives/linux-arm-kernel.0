From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 29 Aug 2011 16:34:38 -0400 (EDT)
Subject: [PATCH] leds: kill CONFIG_LEDS_CLASS option
In-Reply-To: <1314647628-21707-1-git-send-email-bryan.wu@canonical.com>
References: <1314647628-21707-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <alpine.LFD.2.00.1108291630020.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Aug 2011, Bryan Wu wrote:

> Almost all the new leds driver and trigger driver are depends on
> CONFIG_LED_CLASS, so there is no such user with CONFIG_NEW_LEDS=y
> and CONFIG_LED_CLASS=n. Moreover, lots of API functions in led-class.c
> are very common and should be built-in when CONFIG_NEW_LEDS=y.
> 
> Obviously, CONFIG_LEDS_CLASS is pointless. This patch kills it and
> also updates defconfigs which contains CONFIG_LEDS_CLASS.
> 
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---

[...]

> index 6b26666..b322be8 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -69,9 +69,7 @@
>  #include <linux/video_output.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> -#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  #include <linux/leds.h>
> -#endif
>  
>  #define FUJITSU_DRIVER_VERSION "0.6.0"
>  
> @@ -99,14 +97,12 @@
>  /* FUNC interface - responses */
>  #define UNSUPPORTED_CMD 0x80000000
>  
> -#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  /* FUNC interface - LED control */
>  #define FUNC_LED_OFF	0x1
>  #define FUNC_LED_ON	0x30001
>  #define KEYBOARD_LAMPS	0x100
>  #define LOGOLAMP_POWERON 0x2000
>  #define LOGOLAMP_ALWAYS  0x4000
> -#endif
>  
>  /* Hotkey details */
>  #define KEY1_CODE	0x410	/* codes for the keys in the GIRB register */
> @@ -179,7 +175,6 @@ static struct fujitsu_hotkey_t *fujitsu_hotkey;
>  
>  static void acpi_fujitsu_hotkey_notify(struct acpi_device *device, u32 event);
>  
> -#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  static enum led_brightness logolamp_get(struct led_classdev *cdev);
>  static void logolamp_set(struct led_classdev *cdev,
>  			       enum led_brightness brightness);
> @@ -199,7 +194,6 @@ static struct led_classdev kblamps_led = {
>   .brightness_get = kblamps_get,
>   .brightness_set = kblamps_set
>  };
> -#endif
>  
>  #ifdef CONFIG_FUJITSU_LAPTOP_DEBUG
>  static u32 dbg_level = 0x03;
> @@ -260,7 +254,6 @@ static int call_fext_func(int cmd, int arg0, int arg1, int arg2)
>  	return out_obj.integer.value;
>  }
>  
> -#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  /* LED class callbacks */
>  
>  static void logolamp_set(struct led_classdev *cdev,
> @@ -310,7 +303,6 @@ static enum led_brightness kblamps_get(struct led_classdev *cdev)
>  
>  	return brightness;
>  }
> -#endif
>  
>  /* Hardware access for LCD brightness control */
>  
> @@ -900,7 +892,6 @@ static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
>  	/* Suspect this is a keymap of the application panel, print it */
>  	pr_info("BTNI: [0x%x]\n", call_fext_func(FUNC_BUTTONS, 0x0, 0x0, 0x0));
>  
> -#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  	if (call_fext_func(FUNC_LEDS, 0x0, 0x0, 0x0) & LOGOLAMP_POWERON) {
>  		result = led_classdev_register(&fujitsu->pf_device->dev,
>  						&logolamp_led);
> @@ -923,7 +914,6 @@ static int acpi_fujitsu_hotkey_add(struct acpi_device *device)
>  			       result);
>  		}
>  	}
> -#endif
>  
>  	return result;
>  
> @@ -943,13 +933,11 @@ static int acpi_fujitsu_hotkey_remove(struct acpi_device *device, int type)
>  	struct fujitsu_hotkey_t *fujitsu_hotkey = acpi_driver_data(device);
>  	struct input_dev *input = fujitsu_hotkey->input;
>  
> -#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
>  	if (fujitsu_hotkey->logolamp_registered)
>  		led_classdev_unregister(&logolamp_led);
>  
>  	if (fujitsu_hotkey->kblamps_registered)
>  		led_classdev_unregister(&kblamps_led);
> -#endif
>  
>  	input_unregister_device(input);
>  

Is it OK to unconditionally compile the LED code here?


Nicolas
