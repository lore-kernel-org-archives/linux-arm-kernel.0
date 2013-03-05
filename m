From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 05 Mar 2013 16:09:03 +0800
Subject: Debugging missing interrupts
In-Reply-To: <1362392650.11465.49.camel@localhost>
References: <1361777691.4640.34.camel@localhost> <512B1AE6.6070903@atmel.com>
 <1361781448.4640.49.camel@localhost> <512B2D2D.5000206@atmel.com>
 <1361790127.4640.58.camel@localhost> <512C118D.4060105@atmel.com>
 <1362392650.11465.49.camel@localhost>
Message-ID: <5135A81F.8040600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi lexa,

On 3/4/2013 18:24, lexa wrote:
> On Tue, 2013-02-26 at 09:36 +0800, Bo Shen wrote:
>> On 2/25/2013 19:02, lexa wrote:
>>>>>> Which command do you use for recording? (it will give sample rate,
>>>>>> format, and etc)
>>>>
>>>> any information for this?
>>> I tried:
>>> arecord -r 8000 -f S16_LE
>>> arecord -r 8000 -f U8
>>> arecord -r 48000 -f S16_LE
>>> arecord -r 48000 -f U8
>>
>> only these, without "-t wav record.wav" or anything else?
>
> Only this commands, without any additional options. Recorded data
> forwarded to my terminal and i don't see anything except wav header.
>

[Snip]

>
> I enable debugging in ssc driver and tried execute some commands:
>
>
> # arecord -f dat -t wav record.wav
> Recording WAVE 'record.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
> [   73.500000] atmel_ssc_startup: SSC_SR=0x12
> [   73.520000] atmel_ssc_hw_params: RCMR=00010721 RFMR=0000008f TCMR=00010702 TF MR=0000008f
> [   73.530000] atmel_ssc_dai: Starting clock
> [   73.540000] atmel_ssc_dai,hw_params: SSC initialized
> [   73.540000] receive enabled SSC_SR=0x0002040c
> Aborted by signal Interrupt...
> [   79.650000] atmel_ssc_shutdown: receive disabled SSC_SR=0x0000040c
> [   79.650000] atmel_ssc_dau: Stopping clock signal Interrupt...
>
>
> # aplay -f dat  test.dat
> [   92.040000] atmel_ssc_startup: SSC_SR=0x12
> Playing raw data 'test.dat' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
> [   92.060000] atmel_ssc_hw_params: RCMR=00010721 RFMR=0000008f TCMR=00010702 TFMR=0000008f
> [   92.070000] atmel_ssc_dai: Starting clock
> [   92.080000] atmel_ssc_dai,hw_params: SSC initialized
> [   92.080000] transmit enabled SSC_SR=0x0001040f
> [   92.210000] atmel_ssc_shutdown: transmit disabled SSC_SR=0x00010403
> [   92.210000] atmel_ssc_dau: Stopping clock
>
> # arecord -r 8000 -f S16_LE -t wav record.wav
> [  139.770000] atmel_ssc_startup: SSC_SR=0x0
> Recording WAVE 'record.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
> [  139.790000] atmel_ssc_hw_params: RCMR=00010421 RFMR=0000008f TCMR=00010402 TFMR=0000008f
> [  139.800000] atmel_ssc_dai: Starting clock
> [  139.800000] atmel_ssc_dai,hw_params: SSC initialized
> [  139.810000] receive enabled SSC_SR=0x000204c0
> Aborted by signal Interrupt...
> [  141.260000] atmel_ssc_shutdown: receive disabled SSC_SR=0x00000400
> [  141.270000] atmel_ssc_dau: Stopping clock
>
> # aplay  -r 8000 -f S16_LE test.dat
> [  154.710000] atmel_ssc_startup: SSC_SR=0x0
> Playing raw data 'test.dat' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
> [  154.730000] atmel_ssc_hw_params: RCMR=00010421 RFMR=0000008f TCMR=00010402 TFMR=0000008f
> [  154.740000] atmel_ssc_dai: Starting clock
> [  154.750000] atmel_ssc_dai,hw_params: SSC initialized
> [  154.750000] transmit enabled SSC_SR=0x0001040f
> Aborted by signal Interrupt...
> [  155.580000] atmel_ssc_shutdown: transmit disabled SSC_SR=0x00000403
> [  155.580000] atmel_ssc_dau: Stopping clock
>
>
> # arecord -r 8000 -f S16_LE -c 2 -t wav record.wav
> [  176.880000] atmel_ssc_startup: SSC_SR=0x0
> Recording WAVE 'record.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
> [  176.900000] atmel_ssc_hw_params: RCMR=00010721 RFMR=0000008f TCMR=00010702 TFMR=0000008f
> [  176.900000] atmel_ssc_dai: Starting clock
> [  176.910000] atmel_ssc_dai,hw_params: SSC initialized
> [  176.920000] receive enabled SSC_SR=0x000204c0
> Aborted by signal Interrupt...
> [  177.800000] atmel_ssc_shutdown: receive disabled SSC_SR=0x00000400
> [  177.810000] atmel_ssc_dau: Stopping clock
>
>
> # aplay -r 8000 -f S16_LE -c 2 test.dat
> [  193.380000] atmel_ssc_startup: SSC_SR=0x0
> Playing raw data 'test.dat' : Signed 16 bit Little Endian, Rate 8000 Hz, Stereo
> [  193.400000] atmel_ssc_hw_params: RCMR=00010721 RFMR=0000008f TCMR=00010702 TFMR=0000008f
> [  193.410000] atmel_ssc_dai: Starting clock
> [  193.410000] atmel_ssc_dai,hw_params: SSC initialized
> [  193.420000] transmit enabled SSC_SR=0x0001040f
> [  193.920000] atmel_ssc_shutdown: transmit disabled SSC_SR=0x00010403
> [  193.930000] atmel_ssc_dau: Stopping clock
>
>
> aplay works fine, but arecord writes nothing except wav header.

 From the log information for SSC configuration, it is OK.

I guess the routing may have problem. Please try to use alsa utils to 
check or configure and then test again.

Best Regards,
Bo Shen
