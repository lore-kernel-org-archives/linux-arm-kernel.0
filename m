From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 25 Jul 2018 09:12:21 +0000
Subject: [PATCH v3 2/2] fpga: zynq-fpga: Add support for readback
In-Reply-To: <CANk1AXRYX+7hkm93r0maHz1e1Uh-gTKzs==1xjd_CZPQqBLSyA@mail.gmail.com>
References: <1532441858-13507-1-git-send-email-appana.durga.rao@xilinx.com>
 <1532441858-13507-2-git-send-email-appana.durga.rao@xilinx.com>
 <CAAtXAHeVXw4BT7XF+Mu=nR9U9nK=nR_+x+JKSQU1owwPbt_HPA@mail.gmail.com>
 <CY1PR02MB169273A09D4E675A7671375CDC550@CY1PR02MB1692.namprd02.prod.outlook.com>
 <CANk1AXRYX+7hkm93r0maHz1e1Uh-gTKzs==1xjd_CZPQqBLSyA@mail.gmail.com>
Message-ID: <CY1PR02MB1692876485F0557FE798C2D9DC540@CY1PR02MB1692.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,
	
	Thanks for the review...

<Snip> 
> >
> > <Snip>
> >> > +static bool readback_type;
> >> > +module_param(readback_type, bool, 0644);
> >> > +MODULE_PARM_DESC(readback_type,
> >> > +               "readback_type 0-configuration register read "
> >> > +               "1- configuration data read (default: 0)");
> >>
> >> Not sure a module param is the best solution here.
> >
> > Need to provide flexibility to the user to switch between reading of FPGA
> registers and configuration data.
> 
> I suggested calling the attribute 'image' because I thought it would always be
> a read back of the FPGA image information.  I don't think that a sysfs
> attribute's function should change. :)

In Zynq Case it supports two types of the readback (Configuration registers, Configuration data(fpga image))  which may not be the same case for other vendors. 
Since I need to support both the use cases I have differentiated them using module param in the zynq-fpga driver.

As you said we shouldn't change the attribute's function, So in the zynq-fpga driver,
I am planning to add another debugfs attribute for reading back of configuration registers as it is vendor specific readback type.
 (Configuration registers                   ----  Usage:  /sys/kernel/debug/fpga/zynq-fpga/cfgreg_summary) 
(Configuration data(fpga image)    ----   Usage: /sys/kernel/debug/fpga/fpga0/image)
Please let me know your thoughts for the same... 
	
> 
> > One other option is sysfs. Do you want me to implement sysfs path???
> > Any other suggestions???
> 
> You could implement another sysfs attribute for reading FPGA registers
> with a separate ops callback.   Please clarify what it is doing (not
> all FPGAs have this function) and what that will look like when the user reads
> the from the sysfs

AFAIK we shouldn't add another sysfs/debugfs attribute for vendor-specific readback type in the FPGA manager ops.
Please correct me if my understanding is wrong. 

Regards,
Kedar.

> 
> Alan
