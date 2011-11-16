From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 16 Nov 2011 17:49:55 +0100
Subject: [PATCH 3/5] [orion] Move address map setup out of the drivers
 and into platform.
In-Reply-To: <alpine.LFD.2.02.1111160951060.3307@xanadu.home>
References: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
 <1321128007-3520-4-git-send-email-andrew@lunn.ch>
 <alpine.LFD.2.02.1111141855340.3307@xanadu.home>
 <20111115074122.GA2012@lunn.ch>
 <alpine.LFD.2.02.1111151648150.3307@xanadu.home>
 <20111116065940.GH2953@lunn.ch>
 <alpine.LFD.2.02.1111160951060.3307@xanadu.home>
Message-ID: <20111116164955.GA18497@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > How would you suggest using IORESOURCE_BUS? 
> 
> Looking at it closer, I don't think simple resource ranges would be 
> suitable after all.
> 
> I would therefore suggest the following starting point:
> 
> diff --git a/include/linux/mbus.h b/include/linux/mbus.h
> index c11ff29325..2d8989c6e4 100644
> --- a/include/linux/mbus.h
> +++ b/include/linux/mbus.h
> @@ -32,5 +32,17 @@ struct mbus_dram_target_info
>  	} cs[4];
>  };
>  
> +/* 
> + * The Marvell mbus is to be found only on SOCs from the Orion family
> + * at the moment.  Provide a dummy stub for other architectures.
> + */
> +#ifdef CONFIG_PLAT_ORION
> +extern const struct mbus_dram_target_info *mrvl_mbus_dram_info(void);
> +#else
> +static inline const struct mbus_dram_target_info *mrvl_mbus_dram_info(void)
> +{
> +	return NULL;
> +}
> +#endif
>  
>  #endif
> 

So you are suggesting each mach-* implements this function and returns
its specific *_dram_target_info structure? Four functions which are
virtually identical. I would probably just have orion_dram_target_info
in the plat-orion which all mach-* use and one implementation of this
function in plat-oriom.

> However I still have doubts on the usefulness of this exercice.  There 
> are often more than just this mbus stuff to be found into platform data 
> structures anyway.  things like number of ports, PHY addresses, etc.  
> Eventually, those parameters should be retrieved from a device tree, and 
> probably the mbus parameters should be retrieved from there as well.  

I agree about ports, PHY addresses, etc. They are all a property of
the hardware, and belong in device tree. However the memory address of
*_dram_target_info does not belong in the device true. 

> Until then, I don't think we gain much from changing the existing 
> platform data method.

I'm just trying to move towards device tree. *_dram_target_info is one
thing which is blocking this move. The second maybe the clock
speed. It would be nice to move to clkdev, and remove clk from the
platform_data structures.

Do you see a better way to move toward device tree for orion?

   Andrew
