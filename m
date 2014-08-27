From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 27 Aug 2014 15:05:55 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <53FDD40A.3040106@redhat.com>
References: <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <53FCE704.4030103@redhat.com> <20140827093121.GA23186@ulmo>
 <53FDB46C.5010609@redhat.com>
 <CAKON4Owj=b7r_iuOOrr_5R++oSbxqF0G0i4puFz7aTaUF+weuw@mail.gmail.com>
 <53FDD40A.3040106@redhat.com>
Message-ID: <20140827130554.GG23186@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 02:50:18PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 08/27/2014 02:44 PM, jonsmirl at gmail.com wrote:
> 
> <snip>
> 
> >> 1) Serving as *the* fb until a kms driver is present
> > 
> > Why can't we whip together a real device specific fbdev driver and
> > quit trying to run without a device specific driver in place? History
> > has shown that to be bad idea except during early boot when there
> > isn't a choice.
> 
> Writing a kms driver and getting it upstream is not a simple task, and
> starting with a too limited implementation is dangerous as we need to get
> the devicetree binding first from the get go.
> 
> IOW this is not really a realistic answer to problem 1.
> 
> <snip>
> 
> >> 2) Allowing for output of early kernel boot messages.
> > 
> > For this to work the kernel needs to know two things - address of the
> > framebuffer and the x/y layout. Then just nuke this display when the
> > kernel finishes the boot process.
> 
> Please read my earlier mails on how completely flawed it is to write
> "when the kernel finishes the boot process". The problem is that there
> is no way to really determine when this happens.

That doesn't mean we can't create new ways to signal this. One option
would be for userspace to signal this, another would be to have critical
subsystems broadcast such events so that things like the clock framework
can listen for those and react accordingly. The fact remains that
disabling all unused clocks unconditinally at late_initcall time is not
(always) the right thing to do.

What this really is is a policy decision and traditionally we don't like
to dictate policy in the kernel, so having something like an optional
feature that would allow userspace to notify the kernel that it's
initialized doesn't sound like a bad idea. This doesn't necessarily have
to mean that all possible devices have been probed (users could choose
to blacklist modules, etc.) but just an indication that the system is
done with essential tasks (for desktop distributions I would assume that
means the graphical login manager has started).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/fd1a80e0/attachment.sig>
