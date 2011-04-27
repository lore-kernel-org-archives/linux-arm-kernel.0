From: wg@grandegger.com (Wolfgang Grandegger)
Date: Wed, 27 Apr 2011 15:28:50 +0200
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <46D523E49EFF489F9B088AE7B9CD7286@subhasishg>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>	<1303474267-6344-2-git-send-email-subhasish@mistralsolutions.com>
	<4DB1A3B7.7060300@pengutronix.de> <4DB5D452.9050500@grandegger.com>
	<46D523E49EFF489F9B088AE7B9CD7286@subhasishg>
Message-ID: <4DB81A12.1000006@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2011 03:08 PM, Subhasish Ghosh wrote:
>>
>> - Use just *one* value per sysfs file
> 
> SG - I felt adding entry for each mbx_id will clutter the sysfs.
>        Is it ok to do that.

No, see:

http://lxr.linux.no/#linux+v2.6.38/Documentation/filesystems/sysfs.txt#L56

>>>> +static u32 pruss_intc_init[19][3] = {
>>>> + {PRUSS_INTC_POLARITY0, PRU_INTC_REGMAP_MASK, 0xFFFFFFFF},
>>>> + {PRUSS_INTC_POLARITY1, PRU_INTC_REGMAP_MASK, 0xFFFFFFFF},
>>>> + {PRUSS_INTC_TYPE0, PRU_INTC_REGMAP_MASK, 0x1C000000},
>>>> + {PRUSS_INTC_TYPE1, PRU_INTC_REGMAP_MASK, 0},
>>>> + {PRUSS_INTC_GLBLEN, 0, 1},
>>>> + {PRUSS_INTC_HOSTMAP0, PRU_INTC_REGMAP_MASK, 0x03020100},
>>>> + {PRUSS_INTC_HOSTMAP1, PRU_INTC_REGMAP_MASK, 0x07060504},
>>>> + {PRUSS_INTC_HOSTMAP2, PRU_INTC_REGMAP_MASK, 0x0000908},
>>>> + {PRUSS_INTC_CHANMAP0, PRU_INTC_REGMAP_MASK, 0},
>>>> + {PRUSS_INTC_CHANMAP8, PRU_INTC_REGMAP_MASK, 0x00020200},
>>>> + {PRUSS_INTC_STATIDXCLR, 0, 32},
>>>> + {PRUSS_INTC_STATIDXCLR, 0, 19},
>>>> + {PRUSS_INTC_ENIDXSET, 0, 19},
>>>> + {PRUSS_INTC_STATIDXCLR, 0, 18},
>>>> + {PRUSS_INTC_ENIDXSET, 0, 18},
>>>> + {PRUSS_INTC_STATIDXCLR, 0, 34},
>>>> + {PRUSS_INTC_ENIDXSET, 0, 34},
>>>> + {PRUSS_INTC_ENIDXSET, 0, 32},
>>>> + {PRUSS_INTC_HOSTINTEN, 0, 5}
>>>
>>> please add ","
>>
>> Also a struct to describe each entry would improve readability.
>> Then you could also use ARRAY_SIZE.
> 
> SG _ I could not follow this, are you recommending that I create a
> structure with three variables and then create
>            an array for it.
> something like:
> 
> const static struct [] = {
>    {
>    unsigned int reg_base;
>    unsigned int reg_mask;
>    unsigned int reg_val;
>    },
> ...
> };

Yes:

  struct s_name {
	unsigned int base;
	unsigned int mask;
	unsigned int val;
  };

  const static struct s_name array[] = {
	...
  };

> 
>>>> + value = (PRUSS_CAN_GPIO_SETUP_DELAY *
>>>> + (priv->clk_freq_pru / 1000000) / 1000) /
>>>> + PRUSS_CAN_DELAY_LOOP_LENGTH;
>>
>> This calculation looks delicate. 64-bit math would be safer.
> 
> SG - This one works fine. I am dividing it twice to avoid the problem.

Yes, but what if the frequency increases with the next generation of the
hardware?

Wolfgang.
