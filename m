From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Mar 2016 11:57:11 +0200
Subject: [PATCH 1/3] regulator: core: Allow use of "status = disabled" in
 regulator dts nodes
In-Reply-To: <1457730069-31760-1-git-send-email-hdegoede@redhat.com>
References: <1457730069-31760-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160329095711.GI30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Mar 11, 2016 at 10:01:07PM +0100, Hans de Goede wrote:
> The axp20x and axp22x pmics have ldo regulators which are muxed to the
> outside via gpio pins. Unfortunately regulator enable / disable is
> implemented in the hardware via selecting a specific pin-mux option.
> 
> So if we want to use these pins as gpio pins we must not register
> a regulator for these pins at all, otherwise any gpio use (switching
> to input, or writing a value) gets undone when the regulator subsys
> disables unused regulators at the end of kernel-init.
> 
> This commits allows the use of  "status = disabled" in regulator dts
> nodes and makes regulator_register return ENODEV when this is set.
> 
> Note that this commit changes the loop to find the of-node in
> regulator_of_get_init_data from using for_each_available_child_of_node
> to using for_each_child_of_node. regulator_register is the only user
> of regulator_of_get_init_data and the use of for_each_available_child...
> makes little sense there since this will only cause the constraints
> from regulator dts nodes marked as disabled to not be used, the
> actual registration of the regulator would still continue.
> 
> So in a way this patch could be seen as a bugfix as it actually makes
> regulators with an of_node which is marked as not available not register,
> but this behavior change may cause some issues in some places.
> 
> Note that individual regulator drivers / callers of regulator_register
> which may encounter disabled regulator (child) nodes need to be patched to
> handle ENODEV (to not make it fail their probe method).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Any comments on this one?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160329/b78cb4eb/attachment.sig>
