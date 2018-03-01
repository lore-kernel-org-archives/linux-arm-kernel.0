From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Thu, 01 Mar 2018 23:23:57 +0100
Subject: [BUG] Kernel crash on Allwinner H3 due to sound core changes
In-Reply-To: <2424862.oPtAVTfrB9@jernej-laptop>
References: <2424862.oPtAVTfrB9@jernej-laptop>
Message-ID: <63331816.68OamKINx1@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kuninori,

I'm responding to my own mail, since I didn't received yours for some reason 
but I still saw your response in mailing list archive.

Dne sreda, 28. februar 2018 ob 22:02:09 CET je Jernej ?krabec napisal(a):
> Hi all,
> 
> with todays linux-next (next-20180228), kernel on Allwinner H3 SoC crashes
> with dmesg like that: https://pastebin.com/raw/0D5JeaJ8
> 
> I bisected the kernel and first offending commit is:
> be7ee5f32a9a ("ASoC: soc-generic-dmaengine-pcm: replace platform to
> component")
> 
> I know that crash message is completely unrelated to sound subsystem, but it
> turns out that if I disable CONFIG_SND_SUN4I_CODEC kernel works ok, but
> this way I lose analog audio output.
> 
> Any suggestions what can be the issue?

I did a bit of research and I can tell you that different kernel options (some 
drivers added or removed) change how or where kernel crashes. That would 
suggest some kind of memory corruption.

I removed parts of the code from the sun4i codec driver and interestingly it 
doesn't crash if I remove following lines:

ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
if (ret) {
	dev_err(&pdev->dev, "Failed to register against DMAEngine\n");
	goto err_assert_reset;
}

Is it possible that NULL pointer causes troubles somewhere down the line?

I tested this on linux-next, next-20180228 tag.

Best regards,
Jernej
