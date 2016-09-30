From: john3909@gmail.com (John Syne)
Date: Thu, 29 Sep 2016 20:37:19 -0700
Subject: [PATCH 0/4] Add DMA support for ti_am335x_adc driver
In-Reply-To: <ff19f584-e4e5-61ff-046d-68ec37ab51c2@ti.com>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
 <22588f2d-d0de-7911-35ed-92094f7dd28d@kernel.org>
 <ff19f584-e4e5-61ff-046d-68ec37ab51c2@ti.com>
Message-ID: <FB72863E-4B9D-4202-8837-F4B70AA0C045@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I applied your patches to the following kernel:

github.com/RobertCNelson/bb-kernel.git 
branch am33x-v4.8

Changing 
#define REG_DMAENABLE_CLEAR	0x038
to
#define REG_DMAENABLE_CLEAR	0x03C

Also applying the following DTS changes:

		target = <&tscadc>;
		__overlay__ {

			status = "okay";
			adc {
				ti,adc-channels = <0 1 2 3 4 5 6>;
				ti,chan-step-avg = <0x1 0x1 0x1 0x1 0x1 0x1 0x1>;
				ti,chan-step-opendelay = <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;
				ti,chan-step-sampledelay = <0x0 0x0 0x0 0x0 0x0 0x0 0x0>;
			};
		};

Running on a BeagleBoneBlack, I was able to stream samples at 200ksps continuously and it looked stable. 

htop showed CPU utilization between 5% and 7%

Thank you for getting this to work.

Regards,
John




> On Sep 29, 2016, at 6:01 AM, Mugunthan V N <mugunthanvnm@ti.com> wrote:
> 
> On Sunday 25 September 2016 03:11 PM, Jonathan Cameron wrote:
>> On 21/09/16 17:11, Mugunthan V N wrote:
>>>> The ADC has a 64 work depth fifo length which holds the ADC data
>>>> till the CPU reads. So when a user program needs a large ADC data
>>>> to operate on, then it has to do multiple reads to get its
>>>> buffer. Currently if the application asks for 4 samples per
>>>> channel with all 8 channels are enabled, kernel can provide only
>>>> 3 samples per channel when all 8 channels are enabled (logs at
>>>> [1]). So with DMA support user can request for large number of
>>>> samples at a time (logs at [2]).
>>>> 
>>>> Tested the patch on AM437x-gp-evm and AM335x Boneblack with the
>>>> patch [3] to enable ADC and pushed a branch for testing [4]
>>>> 
>>>> [1] - http://pastebin.ubuntu.com/23211490/
>>>> [2] - http://pastebin.ubuntu.com/23211492/
>>>> [3] - http://pastebin.ubuntu.com/23211494/
>>>> [4] - git://git.ti.com/~mugunthanvnm/ti-linux-kernel/linux.git iio-dma
>> Just curious.  How fast is the ADC sampling at in these?  Never that
>> obvious for this driver!
>> 
>> I'm also curious as to whether you started to hit the limits of the
>> kfifo based interface.  Might be worth considering adding alternative
>> support for the dma buffers interface which is obviously much lower
>> overhead.
>> 
>> Good to have this work prior to that as the kfifo stuff is somewhat
>> easier to use.
> 
> Currently ADC clock is 3MHz, which can produce a data rate of 225KBps
> per channel with no open delay and no averaging of samples. So when all
> 8 Channels are enables the data rate will be 1.75MBps
> 
> ADC can be operated at 24MHz, which can generate a data rate of 28MBps
> with all 8 channels enabled and no open delay and averaging, but our
> target is to get 800K samples per second per channel which has a data
> rate of 12.5MBps
> 
> I think with this data rate, DMA will be the best option to implement
> without any data loss and less cpu overload to read the ADC samples.
> 
> Regards
> Mugunthan V N
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
