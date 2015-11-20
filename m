From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 20 Nov 2015 08:58:04 -0800
Subject: [PATH RESEND v2 03/10] tty: xuartps: Always enable transmitter
 in start_tx
In-Reply-To: <564F4A95.3010303@hurleysoftware.com>
References: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
 <1447963344-16266-4-git-send-email-soren.brinkmann@xilinx.com>
 <564F0E75.5020100@hurleysoftware.com>
 <20151120152849.GU32017@xsjsorenbubuntu>
 <564F4A95.3010303@hurleysoftware.com>
Message-ID: <20151120165804.GV32017@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, 2015-11-20 at 11:30AM -0500, Peter Hurley wrote:
> Hi S?ren,
> 
> On 11/20/2015 10:28 AM, S?ren Brinkmann wrote:
> > On Fri, 2015-11-20 at 07:13AM -0500, Peter Hurley wrote:
> >> On 11/19/2015 03:02 PM, Soren Brinkmann wrote:
> >>> start_tx must start transmitting characters. Regardless of the state of
> >>> the circular buffer, always enable the transmitter hardware.
> >>
> >> Why?
> >>
> >> Does cdns_uart_stop_tx() actually stop the transmitter so that
> >> data remains in the transmitter?
> > 
> > Well, I saw my system freezing and the cause seemed to be that the UART
> > receiver and/or transmitters were disabled while the system was trying
> > to print. Hence, I started questioning all locations touching the
> > transmitter/receiver enable. I read the docs in
> > https://www.kernel.org/doc/Documentation/serial/driver, which simply
> > says "Start transmitting characters." for start_tx(). Hence, I thought,
> > this function is probably supposed to just do that and start the
> > transmitter. I'll test whether this patch can be dropped.
> 
> I don't think that patch would fix any freeze problems, but restarting
> the transmitter even if the circ buffer is empty may be necessary to
> push out remaining data when the port is restarted after being stopped.
> 
> IOW, something like
> 
> 	if (uart_tx_stopped(port))
> 		return;
> 
> 	....
> 
> 
> 	if (uart_circ_empty(&port->state->xmit)
> 		return;

Thanks! I'll change the patch accordingly.

> 
> 
> Below is a (work-in-progress) serial driver validation test for flow
> control handling (it may need some tuning for slow line speeds).
> Usual caveats apply. Takes ~40secs @ 115200.

I'll try to get that running on my system.

	Thanks,
	S?ren
