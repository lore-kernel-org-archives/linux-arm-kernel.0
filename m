From: timur@freescale.com (Timur Tabi)
Date: Wed, 11 Jan 2012 15:37:23 -0600
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A777@HQMAIL01.nvidia.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
 <4F0DF1E6.40602@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A777@HQMAIL01.nvidia.com>
Message-ID: <4F0E0113.9090703@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote:
> For monitors attached to user-accessible connectors, whenever the 
> user physically plugs in a new monitor, you need to read the EDID 
> since it could be a new monitor. DVI and HDMI have explicit hotplug 
> detect lines to trigger this. I'm not sure how it works for VGA; 
> perhaps you have to manually reprobe.

We're using DVI, but it turns out that the interrupt signal on the video encoder (TFP410) is not connected to anything on our board, so I can't receive any interrupts.  The only way I would be able to tell is to create a kernel timer to poll the TFP410 through I2C, which I really don't want to do.

> Of course, if this thread is talking about built-in LCD displays 
> where the connectivity is fixed, this is a non-issue, but it's still 
> a relevant general design discussion; hopefully whatever solution 
> that's picked would work for DVI/HDMI even if you're dealing with 
> LCDs right now.

My board supports both LVDS and DVI, and the LVDS is connected to a built-in display, so I need to support both hotplug and non-hotplug.

I also noticed that the I2C interface is not enabled until after the console opens the framebuffer.  That means it's impossible for EDID data to be available before the console switches to the video device.  That doesn't seem right.

-- 
Timur Tabi
Linux kernel developer at Freescale
