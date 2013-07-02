From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 02 Jul 2013 16:06:19 +0200
Subject: [PATCHv3 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
In-Reply-To: <51D2BEA1.6010206@free-electrons.com>
References: <1372094699-3832-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1372094699-3832-3-git-send-email-alexandre.belloni@free-electrons.com>
 <CAOMZO5CLcT=OXYd=ggxpDzUqFxoXSaanqUPGugYLT2Og-VgzCA@mail.gmail.com>
 <51D2BB05.9040201@free-electrons.com>
 <CAOMZO5DZufiOjguOCEbe5n0j=w9B5ezBYh0Rejv3zF5Xht5_qQ@mail.gmail.com>
 <51D2BEA1.6010206@free-electrons.com>
Message-ID: <51D2DE5B.9060309@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 13:50, Alexandre Belloni wrote:
> On 02/07/2013 13:45, Fabio Estevam wrote:
> 
>> Shouldn't this be
>>
>>          i2c at 1 {
>>                  reg = <1>; ?
>>
> 
> No, we have 4 devices on that mux and 2 pins to select the muxing.
> 

OK, got it working.

So, the results:

bitbanging:

# time cat /sys/bus/iio/devices/iio\:device1/in_voltage0_raw
2637
real	0m 0.09s
user	0m 0.01s
sys	0m 0.01s


i2c-mxs PIO mode:

# time cat /sys/bus/iio/devices/iio\:device1/in_voltage0_raw
[   35.007650] [sched_delayed] sched: RT throttling activated
2627
real	0m 7.14s
user	0m 0.02s
sys	0m 0.01s


i2c-mxs PIO mode without LRADC:

# time cat /sys/bus/iio/devices/iio\:device1/in_voltage0_raw
[   18.007432] [sched_delayed] sched: RT throttling activated
2629
real	0m 7.09s
user	0m 0.00s
sys	0m 0.03s


i2c-mxs DMA mode:

# time cat /sys/bus/iio/devices/iio\:device1/in_voltage0_raw
2631
real	0m 0.12s
user	0m 0.01s
sys	0m 0.01s


It seems fine for me.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
