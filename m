From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Wed, 08 May 2013 18:32:13 +0100
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <201305081650.23264.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
Message-ID: <518A8C1D.3090600@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thankyou for your comments.
On 08/05/13 15:50, Arnd Bergmann wrote:
> On Wednesday 08 May 2013, Srinivas KANDAGATLA wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>>
>> This patch introduces syscon_claim, syscon_read, syscon_write,
>> syscon_release APIs to help drivers to use syscon registers in much more
>> flexible way.
>>
>> With this patch, a driver can claim few/all bits in the syscon registers
>> and do read/write and then release them when its totally finished with
>> them, in the mean time if another driver requests same bits or registers
>> the API will detect conflit and return error to the second request.
>>
>> Reason to introduce this API.
>> System configuration/control registers are very basic configuration
>> registers arranged in groups across ST Settop Box parts. These registers
>> are independent of IP itself. Many IPs, clock, pad and other functions
>> are wired up to these registers.
>>
>> In many cases a single syconf register contains bits related to multiple
>> devices, and therefore it need to be shared across multiple drivers at
>> bit level. The same IP block can have different syscon mappings on
>> different SOCs.
>>
>> Typically in a SOC there will be more than hundreds of these registers,
>> which are again divided into groups.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>> CC: Stuart Menefy <stuart.menefy@st.com>
> My feeling is that syscon is the wrong place for this functionality,
> since regmap already handles (some of?) these issues. If you need
> additional synchronization, it's probably best to extend regmap
> as needed so other code besides syscon can take advantage of that
> as well.
Its not just synchronisation that we are looking for.
It also the usability, drivers want to just refer to a syscon
register/bits of it from device trees/non-devicetrees.

The extent of syscon usage is very high in ST set-top-box parts.
As example, ST pinctrl driver uses use bits of the syscon register to
control alternate functions, and many other parameters of pinconf.

In device tree we do something like:
        syscfg_sbc: syscon at fe600000{
            compatible      = "syscon";
            reg        = <0xfe600000 0xb4>;         
        };
and in pinctrl dts file
    st,alt-control    = <&syscfg_sbc  0 0 31>;
    st,od-control    = <&syscfg_sbc  9 0 7>;

the pinctrl driver calls syconf_claim(np, "st,alt-control) to get a
field and then do a read/write on the field.

Just in pinctrl driver we use around 50-100 sysconf registers scatters
across different groups.

Without these new APIs, its very difficult to pass this information to
the drivers.

Thanks,
srini
>
> 	Arnd
>
