From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 12 Jan 2012 12:09:20 +0000
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A848@HQMAIL01.nvidia.com>
References: <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
 <4F0E1843.7030207@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A848@HQMAIL01.nvidia.com>
Message-ID: <20120112120920.GF7180@jl-vm1.vm.bytemark.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote:
> Mitch Bradley wrote at Wednesday, January 11, 2012 4:16 PM:
> > Perhaps I'm missing something, but it appears to me that the model is to
> > set the correct GPIO state before each use, instead of a
> > save-set-use-restore model.
> 
> That's true, but the select action happens implicitly inside the I2C
> core for any and all transactions, AIUI, so the two modes are equivalent.

If there is some reason why it would be desirable to deselect
the DDC I2C bus after transactions, that could be added as an option
to the GPIO I2C mux, but I can't think of a reason.

> For an I2C mux that is controlled via I2C, you can just add the mux
> node as a child of the I2C controller, since it has an I2C address,
> and so putting it there makes sense.

Only if the mux's I2C slave is on the near side of the mux so that
it's always addressable regardless of mux state, and if it's on the
same I2C.

> But for an I2C mux that's controlled using GPIOs or pinmux, there's no
> I2C address so I guess the mux shouldn't be directly underneath the I2C
> controller.

It's connected to: (a) an I2C, and (b) a GPIO.

It can't be child of both, but I don't see why the GPIO can't be
referred by phandle and the I2C it's muxing be the direct parent.
That seems more natural to me.

All the best,
-- Jamie
