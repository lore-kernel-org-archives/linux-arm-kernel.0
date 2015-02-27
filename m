From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 27 Feb 2015 09:01:07 -0800
Subject: Bug in i2c-core?
In-Reply-To: <20150227165944.GA6679@dtor-ws>
References: <54F0507F.6030804@armadeus.com>
 <20150227165944.GA6679@dtor-ws>
Message-ID: <20150227170107.GB6679@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 08:59:44AM -0800, Dmitry Torokhov wrote:
> On Fri, Feb 27, 2015 at 12:09:51PM +0100, S?bastien SZYMANSKI wrote:
> > Hi,
> > 
> > I am writing an I2C touchscreen driver for an i.MX6 based board. I
> > compiled it as a module and when I unload it, I get the following warning:
> > 
> > # modprobe sx8654
> > [   46.261494] input: SX8654 I2C Touchscreen as
> > /devices/soc0/soc/2100000.aips-bus/21a0000.i2c/i2c-0/0-0048/input/input1
> > # rmmod sx8654
> > [   76.435223] ------------[ cut here ]------------
> > [   76.439909] WARNING: CPU: 0 PID: 134 at fs/proc/generic.c:552
> > remove_proc_entry+0x148/0x164()
> > [   76.448582] remove_proc_entry: removing non-empty directory
> > 'irq/208', leaking at least 'sx8654'
> 
> ...
> 
> > When I revert commit e4df3a0 (i2c: core: Dispose OF IRQ mapping at
> > client removal time) I don't get the warning.
> > 
> > Is this a bug in the i2c-core or am I doing something wrong in my driver?
> 
> Yes, this commit breaks all drivers using devm* for IRQ management on
> OF-based systemsi because devm* cleanup happens in device code, after
> bus's remove() method returns. I'd recommend reverting and finding a
> better way (making cleanup a custom devm action as well?).
> 

Also it seems that the original patch is incomplete as I do not see us
disposing the mapping when probe fails...

-- 
Dmitry
