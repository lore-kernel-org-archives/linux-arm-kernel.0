From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 17 Oct 2012 23:36:46 -0700
Subject: [PATCH 11/11] nand: Increase the ecc placement locations to 640
In-Reply-To: <67e0aae3b23f37feb30789f5c6cb342b5684911a.1349778821.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <67e0aae3b23f37feb30789f5c6cb342b5684911a.1349778821.git.vipin.kumar@st.com>
Message-ID: <CAN8TOE_FcjZs3=Q+36S68D9xKmk_m2j+UxqoJSu+p_fgo4cG6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 3:44 AM, Vipin Kumar <vipin.kumar@st.com> wrote:
> Few devices like H27UBG8T2CTR have a writesize/oobsize of 8KB/640B.
> This means that the maximum oobsize has gone up to 640 bytes and consequently
> the maximum ecc placement locations have also gone up to 640.

We really need to change the nand_ecclayout struct sometime. Each one
takes something like 4+4?640+4+32?8 = 2824 bytes now, and we have 4 of
them statically declared in nand_base.c. And most drivers just declare
their own anyway. (fsl_{elbc,ifc}_nand.c have 4 and 5 of them each)

I've thought about dynamically allocating and/or changing its layout
so that we can do eccpos ranges, similar to the oobfree entries. But
this gets harder, with the old ioctl(ECCGETLAYOUT) still hanging
around, a few platform uses of nand_ecclayout, and probably some other
complications.

Anyway, this comes off as basically a complaint, while in fact, I
wanted to see if anyone else agreed and/or had any suggestions. Or,
maybe somebody could convince me not to care...

Brian
