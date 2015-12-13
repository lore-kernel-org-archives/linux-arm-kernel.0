From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 13 Dec 2015 10:09:59 +0100
Subject: [PATCH] i2c: allow building emev2 without slave mode again
In-Reply-To: <2157023.1Ftpc9ZciN@wuerfel>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2592093.cGKEcKVqLU@wuerfel> <20151212162057.GA1530@katana>
 <2157023.1Ftpc9ZciN@wuerfel>
Message-ID: <20151213090959.GB1570@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > The slave_cb callback function is supposed to set the 'value'
> > > here,
> > 
> > Only if a master wants to READ from us.
> 
> Right, and can this never fail?

Exactly. The slave can stretch the clock if the value to be sent to the
master needs some processing first, but it must deliver something.

> With my current code to turn i2c_slave_event() into an empty inline function
> in case of !CONFIG_I2C_SLAVE, the compiler knows that "value" is uninitialized
> at the point where we write it to the register, and warns about it.

I overlooked that your first patch changed this code, sorry. Now I see
the problem.

What about not ifdeffing the inline function and keep the build error
whenever someone uses it without I2C_SLAVE being selected?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151213/837a8f13/attachment.sig>
