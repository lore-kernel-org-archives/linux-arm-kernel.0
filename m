From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 16:50:22 +0200
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <201305081650.23264.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> This patch introduces syscon_claim, syscon_read, syscon_write,
> syscon_release APIs to help drivers to use syscon registers in much more
> flexible way.
> 
> With this patch, a driver can claim few/all bits in the syscon registers
> and do read/write and then release them when its totally finished with
> them, in the mean time if another driver requests same bits or registers
> the API will detect conflit and return error to the second request.
> 
> Reason to introduce this API.
> System configuration/control registers are very basic configuration
> registers arranged in groups across ST Settop Box parts. These registers
> are independent of IP itself. Many IPs, clock, pad and other functions
> are wired up to these registers.
> 
> In many cases a single syconf register contains bits related to multiple
> devices, and therefore it need to be shared across multiple drivers at
> bit level. The same IP block can have different syscon mappings on
> different SOCs.
> 
> Typically in a SOC there will be more than hundreds of these registers,
> which are again divided into groups.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> CC: Stuart Menefy <stuart.menefy@st.com>

My feeling is that syscon is the wrong place for this functionality,
since regmap already handles (some of?) these issues. If you need
additional synchronization, it's probably best to extend regmap
as needed so other code besides syscon can take advantage of that
as well.

	Arnd
