From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sun, 9 May 2010 23:34:28 +0800
Subject: [alsa-devel] about ALC203 linux driver
In-Reply-To: <20100509144940.GA7457@sirena.org.uk>
References: <AANLkTikvaFWOlapz9_HlHc1GBlky_FX1-5ml-iFNGGQW@mail.gmail.com>
	<20100509144940.GA7457@sirena.org.uk>
Message-ID: <AANLkTik0GudetGLF9hF56_VV_tNci8wX0S67gAWDIayq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,


2010/5/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Sun, May 09, 2010 at 10:40:07PM +0800, Wan ZongShun wrote:
>
>> At present, there is a ALC203 AC97 codec in my Winbond ARM board, and
>> I am programming
>> the audio driver based on ALSA, Who can tell me whether the current
>> ALSA is supporting
>> the ALC203 driver?how to enable it?
>
> You need a driver for the AC97 controller your system is using (for most
> ARM systems this is part of the CPU). ?Since AC97 provides a standard
> register interface for CODECs Linux does not require specific support
> for individual AC97 CODECs in order to get core functionality working.
>

There is AC97 support for my chip, and I have implemented the nuc900_ac97.c
,nuc900_pcm.c and machine board c file drivers.The three main
structure definitions
as following:

static struct snd_soc_dai_link nuc900evb_ac97_dai = {
	.name		= "AC97",
	.stream_name	= "AC97 HiFi",
	.cpu_dai	= &nuc900_ac97_dai,
	.codec_dai	= &ac97_dai,
};

static struct snd_soc_card nuc900evb_audio_machine = {
	.name		= "NUC900EVB_AC97",
	.dai_link	= &nuc900evb_ac97_dai,
	.num_links	= 1,
	.platform	= &nuc900_soc_platform,
};

static struct snd_soc_device nuc900evb_ac97_devdata = {
	.card		= &nuc900evb_audio_machine,
	.codec_dev	= &soc_codec_dev_ac97,
};

here, I used the file named ac97.c which is located in
linux-2.6\sound\soc\codecs.
I am sure that it can call the '\sound\pci\ac97ac97_codec.c' file and
identify the
ALC203 (like the log file shows 'nuc900 AC'97 codec is  ALC203',but sometimes
the return value by reading one AC97 register, which is not same as
the writing value to the
AC97 register, that is not my expected result, but sometimes they are same.

any suggestions?



> You can check if there's any specific CODEC support in sound/pci/ac97.
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
