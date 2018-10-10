From: svellattu@mvista.com (Silesh C V)
Date: Wed, 10 Oct 2018 08:19:06 +0530
Subject: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
In-Reply-To: <20181009110210.i6xphyuy5jkcfaug@katana>
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
 <20181009110210.i6xphyuy5jkcfaug@katana>
Message-ID: <CALabi0EZPOeyvXdw-JUvtnVz2tQQbmhAKKrUXfuc7yzcudFArw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On Tue, Oct 9, 2018 at 4:32 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Tue, Oct 09, 2018 at 03:47:24PM +0530, Silesh C V wrote:
> > Some drivers need to find the device on a bus having a specific firmware
> > node. Currently, such drivers have their own implementations to do this.
> > Provide a helper similar to bus_find_device_by_name so that each driver
> > does not have to reinvent this.
> >
> > Signed-off-by: Silesh C V <svellattu@mvista.com>
>
> Looks good in general, however:
>
> We recently had this discussion in I2C world about using the parent if
> the (logical) device has a NULL fw_node [1]. I don't know if the other
> subsystems you modify use logical devices as well? If no, it seems we
> need an additional check for the parent in the I2C core only. If yes,
> this might be considered in your patchset?

We can add an additional check for dev_fwnode(dev->parent) if match
for dev_fwnode(dev) fails in match_fwnode callback. Please correct me
if I am wrong. But then, we will be doing these two comparisons for
each device (until a match is found) on a bus for a bus_find_device
iteration(mostly unnecessarily because I could not find any "match
node" callbacks (for bus_find_device) currently doing this). So,
wouldn't it be better to add this check in exceptional cases (like in
the case of I2C) in the respective subsystems itself ?

Thanks,
Silesh
