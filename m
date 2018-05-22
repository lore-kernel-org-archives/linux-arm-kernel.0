From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 May 2018 17:36:10 +0100
Subject: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <6cb2ac52-258c-332b-e912-809d16e14114@codeaurora.org>
References: <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <152165924074.91116.13025068669916027026@swboyd.mtv.corp.google.com>
 <493c1f5d-df99-ca68-0f90-a7937a696f5d@codeaurora.org>
 <152411734938.46528.9676451637772936597@swboyd.mtv.corp.google.com>
 <20180419120813.GD27188@sirena.org.uk>
 <38f42537-f801-115a-4120-1344a67a0462@codeaurora.org>
 <20180424174111.GH22073@sirena.org.uk>
 <d82ef514-b94f-8ed9-6b1e-e07de2a5f455@codeaurora.org>
 <20180517060948.GI20254@sirena.org.uk>
 <6cb2ac52-258c-332b-e912-809d16e14114@codeaurora.org>
Message-ID: <20180522163610.GD24776@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 01:48:41PM -0700, David Collins wrote:

> The RPMh hardware is configured by the boot loader.  The configuration
> does reflect reality; however, it cannot handle all configurations at
> initialization time.  Specific headroom management typically comes up in
> modem usecases for RF supplies that are sensitive to noise.  This feature

...

> If you really don't like having this feature present in the Linux RPMh
> regulator driver, then I'd be ok removing it.  It is not required for
> SDM845 which the driver is initially targeting.

It's certainly going to be easier to review it separately.

> >> In the case of XOB managed LDO regulators, the LDOs physically can be
> >> configured to different voltages by the bootloader.  However, the RPMh
> >> interface provides no mechanism for the application processor to read or
> >> change that voltage.  Therefore, we need a way to specify such voltages in
> >> a board specific (as opposed to driver specific) manner (i.e. device tree).

> > Is the kernel somehow prevented from varying these voltages?

> Yes.  Physically, there exists no RPMh register to read or write the
> voltage of LDOs managed via XOB.  Additionally, the kernel running on the
> application processor is blocked from configuring the voltage via a direct
> SPMI writes by access permissions that crash the system when violated.

*sigh*  Please provide feedback on the problems this (and everything
else) is causing to the team working on the firmware.  The number of
issues with this interface compared to anything else we've seen is
really noticable, I see what it's trying to do with providing something
like the regulator API is doing but there's quite a lot of missing steps
in it which cause no end of problems for general purpose software
written on top of it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180522/56c284ba/attachment-0001.sig>
