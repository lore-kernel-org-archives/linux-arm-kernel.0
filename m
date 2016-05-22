From: hramrach@gmail.com (Michal Suchanek)
Date: Sun, 22 May 2016 18:59:26 +0200
Subject: sunxi spi clock problem
In-Reply-To: <CAOMqctRS6sEcQ9sy7dqX_TH4gsRiywCN1nUJiQtXAa7NtoboOw@mail.gmail.com>
References: <CAOMqctQKNWz3mYPMModLTZ-hj38GxHqa3mBmDhbfTZz0zJ-CUw@mail.gmail.com>
 <CAGb2v64gYov-tKENkeu0Mf+-qev49JnmR-Q94YvOMHwHti3djQ@mail.gmail.com>
 <CAOMqctRS6sEcQ9sy7dqX_TH4gsRiywCN1nUJiQtXAa7NtoboOw@mail.gmail.com>
Message-ID: <CAOMqctSt613dRA5=Ss=rA8-8L+vHJ9YK_m4SMdqV7DxTymXxNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 May 2016 at 18:41, Michal Suchanek <hramrach@gmail.com> wrote:
> Hello,
>
> The debugfs output shows that spi2 is reparented under pll5 and the
> pll5 frequency remains unchanged.
>
> The request to get a 2GHz clock for spi is fulfilled on best-effort
> basis by giving the 864MHz pll5 clock which should theoretically
> result in 432MHz SPI clock.
>
> On 22 May 2016 at 16:58, Chen-Yu Tsai <wens@csie.org> wrote:
>> Hi,
>>
>> On Sun, May 22, 2016 at 10:18 PM, Michal Suchanek <hramrach@gmail.com> wrote:
>>> Hello,
>>>
>>> I tried running a spidev test program on linux 4.6 and I uncovered a
>>> problem with the sunxi clk framework.
>>>
>>> Basically the system would lock up after running the test program.
>>>
>>> Digging deeper I found that it locks up with commit
>>> [47284e3e0f3c427c93f8583549b6c938e8a18015] spi: sun4i: allow transfers
>>> to set transmission speed
>>>
>>> This exposes a problem with the test program. I try to set the SPI
>>> sped to 1MHz but at other place the speed is multiplied by 1000 to
>>> save typing zeros so the actual requested speed is 1GHz. This commit
>>> probably allows that request to propagate leading to the observed
>>> system lockup.
>>>
>>> Given the parents OSC24M, pll6 and pll5 one of pll6 and pll5 is
>>> probably set up at 2GHz (or both in turn because due to some rounding
>>> neither goes fully up to 2GHz resulting in 864000000 SPI clock). Then
>>> the system locks up.
>>
>> IIRC the mod clock does not propagate rate changes up the tree.
>> But some output from the debugfs would be helpful. See below.
>>
>>>
>>> I can limit the speed in the SPI driver which is rated at 100MHz in
>>> SoC manual (giving 200MHz pll) but the clk driver should probably
>>> limit the clock setting to sane speeds itself.
>>>
>>> I am not familiar with the sunxi-clk code and it has unfortunately no
>>> debug prints which would show what is programmed to what speed.
>>
>> You can use /sys/kernel/debug/clk/clk_summary, provided you have
>> debugfs built in and mounted.
>
> root at a10s:~/spidisp# ./spitest -d -s 1000000 /dev/spidev2.0
> Debug mode.
> /dev/spidev2.0: spi mode 0x0, 8 bits per word, 1000000000 Hz max
> Sending 00
>    clock                         enable_cnt  prepare_cnt        rate
> accuracy   phase
> ----------------------------------------------------------------------------------------
>  osc32k                                   0            0       32768
>        0 0
>  osc24M                                   6            6    24000000
>        0 0
>     ir0                                   0            0    24000000
>        0 0
>     spi2                                  0            0    24000000
>        0 0
>     spi1                                  0            0    24000000
>        0 0
>     spi0                                  0            0    24000000
>        0 0
> ...
> spi_master spi2: spi2.0: timeout transferring 1 bytes at 1000000000Hz for
> 100(100)ms
> spidev spi2.0: SPI transfer failed: -110
> spi_master spi2: failed to transfer one message from queue
> ...
>     pll5                                  1            1   864000000
>        0 0
>        pll5_other                         0            0   864000000
>        0 0
>        pll5_ddr                           1            1   432000000
>        0 0
> ...
> xfer: Connection timed out
> buffer size: 1, result -110
> buffer size: 1, result -110, Connection timed out
> Sending
>    clock                         enable_cnt  prepare_cnt        rate
> accuracy   phase
> ----------------------------------------------------------------------------------------
>  osc32k                                   0            0       32768
>        0 0
>  osc24M                                   6            6    24000000
>        0 0
>     ir0                                   0            0    24000000
>        0 0
>     spi1                                  0            0    24000000
>        0 0
>     spi0                                  0            0    24000000
>        0 0
>     ss                                    0            0    24000000
>        0 0
> ...
>     pll5                                  1            1   864000000
>        0 0
>        pll5_other                         0            0   864000000
>        0 0
>           spi2                            0            0   864000000
>        0 0
>        pll5_ddr                           1            1   432000000
>        0 0
> ...
> maximum buffer size: 0
> Sending 9f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ...
>     pll5                                  1            1   864000000
>        0 0
>        pll5_other                         0            0   864000000
>        0 0
>           spi2                            0            0   864000000
>        0 0
>        pll5_ddr                           1            1   432000000
>        0 0
>     pll4                                  0            0   384000000
>        0 0
>     pll2-prediv                           0
>
> The system locks up here before finishing the output from debugfs and
> actually starting the transfer printed above.
>

Actually the serial console speed is limited so the system might be
doing something else already while transferring this debug output.

Thanks

Michal
