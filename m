From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Apr 2017 17:15:53 +0100
Subject: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
In-Reply-To: <a87748e4-21e7-f65a-5be1-fe4f60bdfbef@st.com>
References: <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
 <20170411211040.htrcedus3c57fbed@sirena.org.uk>
 <86a179ad-7961-18f7-8050-25e0e584c77d@st.com>
 <20170412113251.nfyk5sw6c5pnpmwr@sirena.org.uk>
 <d886a9c7-ca46-f37a-0e82-6ed8d7a4e052@st.com>
 <20170412153831.r2urwvfseipfsrsi@sirena.org.uk>
 <a87748e4-21e7-f65a-5be1-fe4f60bdfbef@st.com>
Message-ID: <20170426161553.oc5pozga53ttypyq@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 08:01:34AM +0000, Olivier MOYSAN wrote:

> 1) 2 static dais NOT exclusive
> 	- dai tx
> 	- dai rx
> The IP exhibits a mode register, where you select mode TX, RX or FD.
> There are 2 two options to manage this register.
> option 1:
> 	start first channel with mode RX or TX
> 	when second channel is started, mode has to be changed to FD.
> 	Transfers have to be stopped before changing configuration
> 	registers, so this leads to cuts in audio stream.
> option 2:
> 	start a first channel with mode FD.
> 	In this case, we may have unpredictable behavior for the stream
> 	which is not already started. probably underrun/overrun.
> So, this solution rises problem for full-duplex management.

> 2) 3 static dais exclusive
> 	- dai tx
> 	- dai rx
> 	- dai rx-tx (fd)
> This is the current implementation.
> The choice of the dai is done at probe time. It is provided by DT 
> through sound-dai parameter.
> When dai fd is selected, after starting first stream, we assume that
> second stream will be started. In this case we wait for second stream
> to be available before enabling IP and starting transfers.

> 3) 1 dynamic dai
> 	- dai rx or tx or fd (according to dma conf in IP node)
> Here the driver exposes only a single dai constructed from dma 
> configuration provided by IP DT node.
> This allows to get ride of sound-dai parameter.

None of these options reflect how normal I2S controllers present
themselves in DT.  To repeat, you should present a single bidirectional
DAI for the single physical bidirectional I2S controller that your
hardware has.

If it's not possible to figure out a way to make the controller support
simultaneous playback and record with the two started independently then
the driver should just return an error if userspace tries to start the
second direction up.  This will severely limit the utility of the driver
as Linux generally treats playback and record independently but that's
going to apply just as much with any of the options involving multiple
DAIs or configuration in DT.  You might be able to do something with
feeding it dummy data I guess?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170426/48459d98/attachment-0001.sig>
