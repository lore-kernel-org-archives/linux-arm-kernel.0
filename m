From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 8 Jun 2012 21:28:12 +0800
Subject: [alsa-devel] [PATCH v1 3/5] ASOC: mmp: add sspa support
In-Reply-To: <20120607221019.GA14525@opensource.wolfsonmicro.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
 <1338791851-21038-4-git-send-email-zhangfei.gao@marvell.com>
 <20120607221019.GA14525@opensource.wolfsonmicro.com>
Message-ID: <CAMj5Bkg7cSaEHm+mz-9ah85J83rQFiw1QNxMP5RBa8BiYJhoqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 8, 2012 at 6:10 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 04, 2012 at 02:37:29PM +0800, Zhangfei Gao wrote:
>> The SSPA is a configurable multi-channel audio serial (TDM) interface.
>> It's configurable at runtime to support up to 128 channels and the
>> number of bits per sample: 8, 12, 16, 20, 24 and 32 bits. It also
>> support stereo format: I2S, left-justified or right-justified.
>
> This looks mostly good (though you want to check your indentation a bit)
> but...
>
>> +static int __init mmp_sspa_modinit(void)
>> +{
>> + ? ? audio_clk = clk_get(NULL, "mmp-audio");
>> + ? ? if (IS_ERR(audio_clk))
>> + ? ? ? ? ? ? return PTR_ERR(audio_clk);
>> +
>> + ? ? sysclk = clk_get(NULL, "mmp-sysclk");
>> + ? ? if (IS_ERR(sysclk))
>> + ? ? ? ? ? ? return PTR_ERR(sysclk);
>> + ? ? clk_enable(audio_clk);
>
> You should be doing this stuff from the driver, not from the module init
> (and ideally you'd be managing the audio clock dynamically). ?Even if
> it's the same clock every time in current silicon it's still a good idea
> to do this from a quality of implementation point of view.

Thanks, will remove the module init, and move clk staff to probe.
However, dynamically control audio_clk make audio subsystem works abnormally.
