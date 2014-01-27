From: jsarha@ti.com (Jyri Sarha)
Date: Mon, 27 Jan 2014 21:40:03 +0200
Subject: [alsa-devel] [PATCH RFC v3 0/8] Beaglebone-Black HDMI audio
In-Reply-To: <52E68A00.5030207@metafoo.de>
References: <y> <cover.1390836773.git.jsarha@ti.com>
 <52E6806A.2090109@metafoo.de> <52E686B2.9060806@ti.com>
 <52E68A00.5030207@metafoo.de>
Message-ID: <52E6B613.9050400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2014 06:32 PM, Lars-Peter Clausen wrote:
> On 01/27/2014 05:17 PM, Jyri Sarha wrote:
>> On 01/27/2014 05:51 PM, Lars-Peter Clausen wrote:
>>> Hi,
>>>
>>> I think you should try to get this in sync with the work Jean-Francois is
>>> currently doing[1]. Having the HDMI transmitter register a CODEC device is
>>> definitely the right approach, compared to the rather 'interesting'
>>> constraints stuff you do in patch 4.
>>>
>>
>> Oh, Jean-Francois's patches are now out. I'll take those into use, but I am
>> afraid it still does not save me from the constraint stuff.
>>
>> The most complex piece of code comes from limited sample-rate availability,
>> which is coming Beaglebone-Black desing (available i2s master clock), not
>> from the HDMI encoder itself. It does not help with the stereo only
>> limitation either, because it comes from the one wire only audio data
>> connection on BBB.
>>
>> Support for S16_LE could maybe be added if the tda998x specific codec would
>> fiddle with CTS_N predivider-setting (K select) according to the used sample
>> width. But it appears Cobox plays all the sample formats fine without this
>> change, so the question is if playing around with CTS_N predivider would
>> break already working support there (something to be tested).
>
> The ASoC core will set the constraints for the audio format/rate to the
> intersection of what is supported by the CODEC and the CPU DAI. So if the
> limitation comes from the CPU DAI the constraints should be applied there
> and not in the machine driver. Similar if the tda998x only supports 32 bit
> samples it should advertise this and the compound card will only support 32
> bit samples.
>

Yes. I know. But these limitations come from the run time setup of the 
audio serial bus and those details are not available to the cpu dai at 
the register time.

If more of the McASP configuration data would be moved to DT, instead of 
giving it in set_sysclk, set_fmt, etc. calls it would be possible for 
the driver code produce more accurate constraints at register time. 
However that would change McASP driver a lot and would possibly break 
some of the legacy support.

Best regards,
Jyri
