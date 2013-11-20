From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Nov 2013 10:21:50 -0700
Subject: [PATCH V4] kbuild: dtbs_install: new make target
In-Reply-To: <20131120170845.GJ28859@titan.lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <1384896475-8744-1-git-send-email-jason@lakedaemon.net>
 <528BDEED.8080708@wwwdotorg.org>
 <20131120170845.GJ28859@titan.lakedaemon.net>
Message-ID: <528CEFAE.4080502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 10:08 AM, Jason Cooper wrote:
> On Tue, Nov 19, 2013 at 02:58:05PM -0700, Stephen Warren wrote:
>> On 11/19/2013 02:27 PM, Jason Cooper wrote:
>>> Unlike other build products in the Linux kernel, there is no 'make
>>> *install' mechanism to put devicetree blobs in a standard place.
>>>
>>> This patch is an attempt to fix this problem.  Akin to 'make install',
>>> this creates a new make target, dtbs_install.  The script that gets
>>> called defers to a distribution or user supplied installdtbs binary,
>>> if found in the system.  Otherwise, the default action is to install a
>>> given dtb into
>>>
>>>   /lib/modules/${kernel_version}/devicetree/${dts_filename}.dtb
>>
>> I still don't see why you wouldn't install the files in
>> /lib/devicetrees, but I suppose that location is fine.
> 
> Hmm, after sleeping on it a night, I've come around.  If we install to
> /lib/devicetree/${kernel_version}/, then when the devicetree moves to
> it's own repo, it should be able to install to /lib/devicetree.
> 
> So this:
>  1) hints at the still strong connection between a dtb and the kernel
>     version
>  2) doesn't sound odd like installing dtbs into a modules directory
>  3) allows a future independent repository to install
>     non-kernel-version-dependent dtbs in a sane location.
> 
> I'm still not in favor of installing to /boot/anything since /boot is
> often a separate, small partition.  I even set mine not to automount.
> The number and size of dtbs is only going to grow.  Better to install
> them in a location with lots of space, and /lib is used to having the
> kernel modules installed in it.

Isn't installdtbs (the in-kernel version) typically installing to a
temporary staging directory, which is then packaged up by some process?

If you point DESTDIR/INSTALL_MOD_PATH/... at / when running it, or
install a custom /sbin/installdtbs that ignores the path and always
copies the files to /, then haven't you specifically opted in to /boot
being an available and appropriate location?

As such, I'm tending to agree with Grant that /boot/devicetrees/...
makes more sense that /lib/devicetrees/...; my use of "/lib" above was
simply me writing to fast and typing the wrong thing!
