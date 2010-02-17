From: tim_th@posti.tyyppi.org (Timo TH)
Date: Wed, 17 Feb 2010 19:16:54 +0200
Subject: AT91SAM9263 USB Serial hang?
In-Reply-To: <fc09324d1002102340o4444c8abve6d1d6bb5289d461@mail.gmail.com>
References: <fc09324d1002102340o4444c8abve6d1d6bb5289d461@mail.gmail.com>
Message-ID: <fc09324d1002170916l6ce9c6c4i58f41d2b9db6818f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FYI: This was caused by microcom's and pppd's inability to TIOCMSET
the RTS flags the way ftdi_sio wants it.

On 11 February 2010 09:40, Timo TH <tim_th@posti.tyyppi.org> wrote:
> Anyone seen this kind of a problem?
>
> Environment : ARM9 SAM9263ek, gprs modem on usb, (pppd 2.4.4)
>
> With Linux 2.6.27.34 everything worked OK. (with at91-patches)
> Upgraded to Linux 2.6.31.6 and now everything works upto point where
> data connection should be made.
> Something wrong with handling of DTR or DCD or what?
>
>
>
> # modprobe ftdi_sio
> usbcore: registered new interface driver usbserial
> USB Serial support registered for generic
> usbcore: registered new interface driver usbserial_generic
> USB Serial support registered for FTDI USB Serial Device
> ftdi_sio 1-2.2:1.0: usb_probe_interface
> ftdi_sio 1-2.2:1.0: usb_probe_interface - got id
> ftdi_sio 1-2.2:1.0: FTDI USB Serial Device converter detected
> usb 1-2.2: Detected FT2232C
> usb 1-2.2: Number of endpoints 2
> usb 1-2.2: Endpoint 1 MaxPacketSize 64
> usb 1-2.2: Endpoint 2 MaxPacketSize 64
> usb 1-2.2: Setting MaxPacketSize 64
> usb 1-2.2: FTDI USB Serial Device converter now attached to ttyUSB0
> ftdi_sio: v1.5.0:USB FTDI Serial Converters Driver
>
> # microcom /dev/ttyUSB0
> AT
> OK
> AT+CPIN=0000
> OK
> AT+CREG?
> +CREG: 0,1
> ATD*98#
> //// No reply of any kind
>
> With 2.6.27.34, everything above is same (except ftdi_sio is 1.4.3)
> and there ATD gets reply
> CONNECT
>
> Strange detail, If instead of microcom doing
> # cat < /dev/ttyUSB0 in one terminal, and just echo in the AT commands
> in another terminal, then the cat displays CONNECT
>
> But this is no help for my goal, since I'm trying to use pppd and it
> only gets timeout to its ATD command.
>
>
