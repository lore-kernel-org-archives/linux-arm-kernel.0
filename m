From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Aug 2010 15:46:05 +0100
Subject: [PATCH v2 03/20] mmc: support embedded data field in mmc_host
In-Reply-To: <AANLkTim6Yuor4CAEmQPs3zPVz1svEbckzO0HHeFWGmjy@mail.gmail.com>
References: <AANLkTi=BUX59heXAW2Uf4wZo2dSS19Je54dkQ5u2YGAW@mail.gmail.com>
	<AANLkTimZQKj7H_GeE=+O9cwxEMTR+LhfFbt=AyXGzN3d@mail.gmail.com>
	<AANLkTikfRja-h9mz7uyRXCZNZjKdU_yB8e58XQucUzrn@mail.gmail.com>
	<AANLkTi=vhWV1RNyemtfppfjvLYAbzd3aRjFOVgLLpG3Z@mail.gmail.com>
	<AANLkTin4m8gJR50zwMB2b0jRMHdNA6CQToKBTAhOL9wF@mail.gmail.com>
	<AANLkTinu2S19r8fueM-jVkc35XL2G0Z16BddE92Ci9KB@mail.gmail.com>
	<20100804114147.GB6852@n2100.arm.linux.org.uk>
	<AANLkTi=Dqs_qg=BsoNBTjvJbG+ub+zMv8ctbrJSGPJJJ@mail.gmail.com>
	<AANLkTimrb5P9cVo30y_udoi4+vu3cM4YzfpDaYCfwGEA@mail.gmail.com>
	<AANLkTim6Yuor4CAEmQPs3zPVz1svEbckzO0HHeFWGmjy@mail.gmail.com>
Message-ID: <20100806144605.GA21015@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 06, 2010 at 01:02:24PM +0300, Ohad Ben-Cohen wrote:
> We have Russell's suggestion which is nice and simple, but it has the
> 1 device limitation.

You could make it generic by doing something like this:

#define set_device_data(name, type, index, data)			\
 ({									\
    extern void __set_device_data(const char *, int, void *, size_t);	\
    BUILD_BUG_ON(!__same_type(type, *data));				\
    __set_device_data(name ":" #type, index, data, sizeof(type));	\
 })

#define get_device_data(name, type, index) ({				\
  extern void *__get_device_data(const char *, int);			\
  type *__ptr = __get_device_data(name ":" #type, index);		\
  __ptr; })

And now we have something that takes a string and index to use as a lookup
key in some kind of list - and it's typesafe (because the lookup key is
dependent on the stringified type.)

But... at this point I feel that we're getting too complicated, and will
get shouted at to use something like DT which already solves this problem.
